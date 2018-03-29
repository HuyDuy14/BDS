//
//  DetailMapsViewController.swift
//  BDS
//
//  Created by Duy Huy on 12/5/17.
//  Copyright © 2017 Duy Huy. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import UserNotifications
import RxSwift
import RxCocoa

class DetailMapsViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imageShared: UIImageView!
    @IBOutlet weak var sharedButton: UIButton!
    @IBOutlet weak var imageSave: UIImageView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var saveLandButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    var isGrantedNotificationAccess: Bool = false
    let locationManager = CLLocationManager()
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    let zoomLevel: Float = 20.0
    var listLatitudes: [Double] = []
    var listLongitudes: [Double] = []
    
    var is3D:Bool = false
    var project:ProjectsModel!
    var landForSale:LandSaleModel!
    let disposeBag = DisposeBag()
    var inforMaps:InforMapsProjectViewController!
    var isShow:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Util.shared.projectsDetail != nil
        {
            self.sharedButton.isHidden = true
            self.btnBack.isHidden = true
            self.imageSave.isHidden = true
            self.imageShared.isHidden = true
            self.saveLandButton.isHidden = true
            self.project = Util.shared.projectsDetail
        }
        self.settingMaps()
        self.mapView.clear()
        
       
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
        if Util.shared.projectsDetail == nil
        {
            self.addBottomSheetView()
        }
        if self.project != nil {
            self.imageSave.isHidden = true
            self.saveLandButton.isHidden = true
            if self.project.isLike == true
            {
                self.saveLandButton.tintColor = UIColor.red
            }
            else
            {
                self.saveLandButton.tintColor = UIColor.lightGray
            }
        }
        else
        {
            if self.landForSale.isLike == true
            {
                self.saveLandButton.tintColor = UIColor.red
            }
            else
            {
                self.saveLandButton.tintColor = UIColor.lightGray
            }
        }

    }
    
    @IBAction func zoomButtonDidTap(_ sender: Any) {
        self.mapView.clear()
        if self.project != nil
        {
            let coordinates = CLLocationCoordinate2D(latitude: Double(project.lat)!, longitude: Double(project.lng)!)
            let marker = GMSMarker(position: coordinates)
            marker.map = self.mapView
            marker.icon = #imageLiteral(resourceName: "icon_macker")
            mapView.animate(toLocation: coordinates)
        }
        else
        {
            let coordinates = CLLocationCoordinate2D(latitude: Double(self.landForSale.land_lat)!, longitude: Double(self.landForSale.land_lng)!)
            let marker = GMSMarker(position: coordinates)
            marker.map = self.mapView
            marker.icon = #imageLiteral(resourceName: "icon_macker ")
            mapView.animate(toLocation: coordinates)
        }
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
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.popToView()
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        
        if self.project != nil
        {
            self.showHUD("")
            if self.project.isLike == true
            {
                APIClient.shared.cancelNews(id: self.project.id, type: 2).asObservable().bind(onNext: { result in
                    self.hideHUD()
                    for i in 0..<(Util.shared.listProjectSave.count - 1)
                    {
                        if Util.shared.listProjectSave[i].id == self.project.id
                        {
                            Util.shared.listProjectSave.remove(at: i)
                        }
                    }
                     self.project.isLike = false
                    self.saveLandButton.tintColor = UIColor.lightGray
                }).disposed(by: self.disposeBag)
            }
            else
            {
                APIClient.shared.saveNews(id: self.project.id, type: 2).asObservable().bind(onNext: { result in
                    self.hideHUD()
                    Util.shared.listProjectSave.append(self.project)
                     self.project.isLike = true
                    self.saveLandButton.tintColor = UIColor.red
                }).disposed(by: self.disposeBag)
            }
        }
        else
        {
            self.showHUD("")
            if self.landForSale.isLike == true
            {
                APIClient.shared.cancelNews(id: self.landForSale.id, type: 3).asObservable().bind(onNext: { result in
                    self.hideHUD()
                    for i in 0..<(Util.shared.listBDS.count - 1)
                    {
                        if Util.shared.listBDS[i].id == self.landForSale.id
                        {
                            Util.shared.listBDS.remove(at: i)
                        }
                    }
                     self.landForSale.isLike = false
                    self.saveLandButton.tintColor = UIColor.lightGray
                }).disposed(by: self.disposeBag)
            }
            else
            {
                APIClient.shared.saveNews(id: self.landForSale.id, type: 3).asObservable().bind(onNext: { result in
                    self.hideHUD()
                    Util.shared.listBDS.append(self.landForSale)
                    self.saveLandButton.tintColor = UIColor.red
                     self.landForSale.isLike = true
                }).disposed(by: self.disposeBag)
            }
        }
    }
    
    func addBottomSheetView() {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let bottomSheetViewController = storyboard.instantiateViewController(withIdentifier: "InforMapsProjectViewController") as? InforMapsProjectViewController
        if self.project != nil
        {
            bottomSheetViewController?.project = self.project
        }
        else
        {
            bottomSheetViewController?.landForSale = self.landForSale
        }
        self.addChildViewController(bottomSheetViewController!)
        self.view.addSubview((bottomSheetViewController?.view)!)
        bottomSheetViewController?.didMove(toParentViewController: self)
        let height = view.frame.height
        let width  = view.frame.width
        self.inforMaps = bottomSheetViewController
//        self.inforMaps.animationShowView()
        bottomSheetViewController?.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    @IBAction func sharedButtonDidTap(_ sender: Any) {
        if self.landForSale != nil
        {
            AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "d" + self.landForSale.alias + "-" + self.landForSale.id + ".html", image: #imageLiteral(resourceName: "demo"))
        }
        else
        {
            AppDelegate.shared?.shareImage(controller: self, link: API.linkImage + "p" + self.project.alias + "-" + self.project.id + ".html", image: #imageLiteral(resourceName: "demo"))
        }
    }
    
    
}
extension DetailMapsViewController: CLLocationManagerDelegate {
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
            self.mapView.clear()
            if self.project != nil
            {
                if self.project.lng.count == 0 || self.project.lng.count == 0
                {
                    return
                }
                let coordinates = CLLocationCoordinate2D(latitude: Double(project.lat)!, longitude: Double(project.lng)!)
                let marker = GMSMarker(position: coordinates)
                marker.map = self.mapView
                marker.icon = #imageLiteral(resourceName: "icon_marker")
                mapView.animate(toLocation: coordinates)
            }
            else
            {
                if self.landForSale.land_lat.count == 0 || self.landForSale.land_lng.count == 0
                {
                    return
                }
                let coordinates = CLLocationCoordinate2D(latitude: Double(self.landForSale.land_lat)!, longitude: Double(self.landForSale.land_lng)!)
                let marker = GMSMarker(position: coordinates)
                marker.map = self.mapView
                marker.icon = #imageLiteral(resourceName: "icon_marker")
                mapView.animate(toLocation: coordinates)
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
extension DetailMapsViewController:InforMapsProjectViewControllerDelegate
{
    func showFullInfor(_ controller: InforMapsProjectViewController) {
        
    }
    
    func showHidePopOver(_ controller: InforMapsProjectViewController) {
        self.isShow = false
    }
}

extension DetailMapsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        if self.inforMaps == nil
        {
            return
        }
        if self.isShow == false
        {
            self.isShow = true
            self.destinationLatitude = coordinate.latitude
            self.destinationLongtitude = coordinate.longitude
            let marker = GMSMarker(position: coordinate)
            marker.map = self.mapView
            self.inforMaps.animationShowView()
        }
       
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if self.inforMaps == nil
        {
            return false
        }
        self.inforMaps.animationShowView()

        return true
    }
}

