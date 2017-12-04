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

class MapsViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var inforMaps:InforMapsViewController!
    
    var isGrantedNotificationAccess: Bool = false
    let locationManager = CLLocationManager()
    var originLatitude: Double = 0
    var originLongtitude: Double = 0
    var destinationLatitude: Double = 0
    var destinationLongtitude: Double = 0
    let zoomLevel: Float = 15.0
    var listLatitudes: [Double] = []
    var listLongitudes: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.settingMaps()
    }

    func settingMaps()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = false
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(6, maxZoom: 16)
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        self.addBottomSheetView()
        
    }
    
    @IBAction func zoomButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func DButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func presendMenuButtonDidTap(_ sender: Any) {
       self.showMenuView()
    }
    
    func addBottomSheetView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bottomSheetViewController = storyboard.instantiateViewController(withIdentifier: "InforMapsViewController") as? InforMapsViewController
        self.inforMaps = bottomSheetViewController
        
        self.addChildViewController(bottomSheetViewController!)
        self.view.addSubview((bottomSheetViewController?.view)!)
        bottomSheetViewController?.didMove(toParentViewController: self)
        bottomSheetViewController?.controller.delegate = self
        let height = view.frame.height
        let width  = view.frame.width
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return true
    }
}
extension MapsViewController:LandForSaleViewControllerDelegate
{
    func disLoadDataMaps(_ controller: LandForSaleViewController, listData: [LandSaleModel]) {
        self.inforMaps.numberNews.text = " \(listData.count) tin rao"
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
            marker.userData = listData[i]
        }
    }
}

