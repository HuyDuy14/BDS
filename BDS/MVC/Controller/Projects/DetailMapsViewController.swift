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

class DetailMapsViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var inforMaps:InforMapsViewController!
    
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
        mapView.setMinZoom(2, maxZoom: 20)
        mapView.delegate = self
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        self.addBottomSheetView()
        
    }
    
    @IBAction func zoomButtonDidTap(_ sender: Any) {
        self.mapView.clear()
        let coordinates = CLLocationCoordinate2D(latitude: Double(project.lat)!, longitude: Double(project.lng)!)
        let marker = GMSMarker(position: coordinates)
        marker.map = self.mapView
        marker.icon = #imageLiteral(resourceName: "icon_macker ")
        mapView.animate(toLocation: coordinates)
        
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
    }
    
    func addBottomSheetView() {
        let storyboard = UIStoryboard(name: "Projects", bundle: nil)
        let bottomSheetViewController = storyboard.instantiateViewController(withIdentifier: "InforMapsProjectViewController") as? InforMapsProjectViewController
        bottomSheetViewController?.project = self.project
        self.addChildViewController(bottomSheetViewController!)
        self.view.addSubview((bottomSheetViewController?.view)!)
        bottomSheetViewController?.didMove(toParentViewController: self)
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetViewController?.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
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


extension DetailMapsViewController: GMSMapViewDelegate {
    
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

