//
//  MapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 11/30/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import UserNotifications
import RxCocoa
import RxSwift

class MapsViewController: BaseViewController {

    @IBOutlet weak var nameMaps: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnTypeSelect: UIButton!
    
    let disposeBag = DisposeBag()
    var inforMaps:InforMapsViewController!
    var inforMapsDetail:InforMapsProjectViewController!
    
    var isGrantedNotificationAccess: Bool = false
    let locationManager = CLLocationManager()
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    let zoomLevel: Float = 20.0
    var listLatitudes: [Double] = []
    var listLongitudes: [Double] = []
    
    var landForSale:LandSaleModel!
    var indexType:Int = 3
    var is3D:Bool = false
    var isCheckShow:Bool = false
    
    var listPicker:[ModelPicker] = []
    let pickerView = PickerView.getFromNib()
    var r = "2"
    var selectDistance:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingMaps()
        for i in 1...20
        {
            let model = ModelPicker(id: i-1, name: "\(i)")
            self.listPicker.append(model)
        }
        self.pickerView.delegate = self
    }
    
    func settingMaps()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = false
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(2, maxZoom: 20)
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
    @IBAction func selectTypeButtonDidTap(_ sender: UIButton) {
        self.showPopOverGroup(sender: sender)
    }
    
    func showPopOverGroup(sender:UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popoverCV = storyboard.instantiateViewController(withIdentifier: "PopOverTypeMapsViewController") as? PopOverTypeMapsViewController
        popoverCV?.finish = { index in
            
            switch index
            {
            case 1:
                self.pickerView.listData = self.listPicker
                self.pickerView.config.startIndex = self.selectDistance
                self.pickerView.show(inVC: self)
            case 2:
                self.indexType = index
                self.inforMaps.type = "rent"
                self.inforMaps.r = self.r
                self.inforMaps.lat = String(self.originLatitude)
                self.inforMaps.lng = String(self.originLongtitude)
                self.inforMaps.loadData()
                self.btnTypeSelect.setTitle("Nhà đất thuê", for: .normal)
            case 3:
                self.indexType = index
                self.inforMaps.r = self.r
                self.inforMaps.type = "sale"
                self.inforMaps.lat = String(self.originLatitude)
                self.inforMaps.lng = String(self.originLongtitude)
                self.btnTypeSelect.setTitle("Nhà đất bán", for: .normal)
                self.inforMaps.loadData()
            default:
                self.indexType = index
                self.inforMaps.r = self.r
                self.inforMaps.type = "project"
                self.inforMaps.lat = String(self.originLatitude)
                self.inforMaps.lng = String(self.originLongtitude)
                self.btnTypeSelect.setTitle("Dự án", for: .normal)
                self.inforMaps.loadData()
            }
        }
        popoverCV?.modalPresentationStyle = .popover
      
        let popController = popoverCV?.popoverPresentationController
        popController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popController?.sourceView = sender;
        popController?.delegate = self
        popController?.sourceRect = sender.bounds
        self.present(popoverCV!, animated: true, completion: nil)
        
    }

    
    @IBAction func zoomButtonDidTap(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: self.originLatitude,
                                              longitude: self.originLongtitude,
                                              zoom: 9)
         mapView.animate(to: camera)

    }
    
    @IBAction func DButtonDidTap(_ sender: Any) {
        if self.is3D == false {
            self.mapView.mapType = GMSMapViewType.satellite
            self.is3D = true
        }
        else
        {
            self.mapView.mapType = GMSMapViewType.normal
            self.is3D = false
        }
    }
    
    @IBAction func presendMenuButtonDidTap(_ sender: Any) {
       self.showMenuView()
    }
    
    func addBottomSheetView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bottomSheetViewController = storyboard.instantiateViewController(withIdentifier: "InforMapsViewController") as? InforMapsViewController
        self.inforMaps = bottomSheetViewController
        bottomSheetViewController?.delegate = self
        bottomSheetViewController?.lat = String(self.originLatitude)
        bottomSheetViewController?.lng =  String(self.originLongtitude)
//        bottomSheetViewController?.animationShow()
        self.addChildViewController(bottomSheetViewController!)
        self.view.addSubview((bottomSheetViewController?.view)!)
        bottomSheetViewController?.didMove(toParentViewController: self)
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetViewController?.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    func addBottomSheetViewDetail() {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let bottomSheetViewController = storyboard.instantiateViewController(withIdentifier: "InforMapsProjectViewController") as? InforMapsProjectViewController
        bottomSheetViewController?.landForSale = self.landForSale
        bottomSheetViewController?.delegate = self
        self.addChildViewController(bottomSheetViewController!)
        self.view.addSubview((bottomSheetViewController?.view)!)
        bottomSheetViewController?.didMove(toParentViewController: self)
        let height = view.frame.height
        let width  = view.frame.width
        self.inforMapsDetail = bottomSheetViewController
        self.inforMapsDetail.view.isHidden = true
        bottomSheetViewController?.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    
}
extension MapsViewController: CLLocationManagerDelegate {
    //Handle incoming location events.
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location: CLLocation = locations.last {
            let locationLatitude = location.coordinate.latitude
            let locationLongtitude = location.coordinate.longitude
            self.originLatitude = locationLatitude
            self.originLongtitude = locationLongtitude
            mapView.clear()
             if self.isCheckShow == false
             {
                self.isCheckShow = true
                self.addBottomSheetViewDetail()
                self.addBottomSheetView()
            }
            let coordinates = CLLocationCoordinate2D(latitude: locationLatitude, longitude: locationLongtitude)
            let marker = GMSMarker(position: coordinates)
            marker.map = self.mapView
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.2)
            let camera = GMSCameraPosition.camera(
                withLatitude: locationLatitude,
                longitude: locationLongtitude, zoom: zoomLevel)
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}


extension MapsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.destinationLatitude = coordinate.latitude
        self.destinationLongtitude = coordinate.longitude
        let marker = GMSMarker(position: coordinate)
        
        marker.map = self.mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
       
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        if let landForSale =  marker.userData as? LandSaleModel
        {
            if self.landForSale == nil || self.landForSale.id != landForSale.id
            {
                self.landForSale = landForSale
                self.loadDataLand()
            }
//
        }
       
        return true
    }
    
    func loadDataLand()
    {
        self.showHUD("")
        APIClient.shared.getDetailSale(id: self.landForSale.id).asObservable().bind(onNext: {result in
            self.landForSale = LandSaleModel(JSON: result.data!)
            self.inforMapsDetail.animationHideView()
            self.inforMapsDetail.view.isHidden = false
            self.inforMaps.view.isHidden = true
            
            self.inforMapsDetail.landForSale = self.landForSale
            self.inforMapsDetail.fillData()
            self.inforMapsDetail.animationShowView()
            self.hideHUD()
        }).disposed(by: self.disposeBag)
    }
}
extension MapsViewController:InforMapsProjectViewControllerDelegate
{
    func showHidePopOver(_ controller: InforMapsProjectViewController) {
        self.landForSale = nil
    }
    
    func showFullInfor(_ controller: InforMapsProjectViewController) {
        let storyboard = UIStoryboard(name: "MenuHome", bundle: nil)
        let showDetail = storyboard.instantiateViewController(withIdentifier: "DetailLanforSaleViewController") as? DetailLanforSaleViewController
        showDetail?.landForSale = self.landForSale
        self.pushViewController(viewController: showDetail)
    }
}
extension MapsViewController:InforMapsViewControllerDelegate
{
    func disLoadDataMaps(_ controller: InforMapsViewController, listData: [LandSaleModel]) {
//        self.inforMaps.view.isHidden = false
        self.inforMapsDetail.view.isHidden = true
        self.inforMapsDetail.animationHideView()
        if self.indexType == 2 || self.indexType == 3
        {
          self.inforMaps.numberNews.text = " \(listData.count) tin rao"
        }
        else
        {
          self.inforMaps.numberNews.text = " \(listData.count) dự án"
        }
        self.mapView.clear()
        self.listLatitudes = []
        self.listLongitudes = []
        for data in listData
        {
            let lat = data.land_lat
            let log = data.land_lng
            self.listLatitudes.append(Double(lat)!)
            self.listLongitudes.append(Double(log)!)
          
        }
        for i in 0..<self.listLongitudes.count {
            let coordinates = CLLocationCoordinate2D(latitude: self.listLatitudes[i], longitude: self.listLongitudes[i])
            let marker = GMSMarker(position: coordinates)
            marker.map = self.mapView
            marker.icon = #imageLiteral(resourceName: "icon_marker")
            marker.userData = listData[i]
        }
        self.mapView.animate(toZoom: 15)
    }
}
extension MapsViewController: UIPopoverPresentationControllerDelegate
{
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension MapsViewController:PickerViewDelegate
{
    func miPickerViewDidCancelSelection(_ amPicker: PickerView) {
        
    }
    
    func miPickerView(_ amPicker: PickerView, didSelect picker: ModelPicker) {
        self.r = picker.name
        self.selectDistance = picker.id
        self.inforMaps.lat = String(self.originLatitude)
        self.inforMaps.lng = String(self.originLongtitude)
        self.inforMaps.r = self.r
        self.inforMaps.loadData()
        
    }
}
