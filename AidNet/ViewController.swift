//
//  ViewController.swift
//  UHCM
//
//  Created by shuyu liu on 2019-03-16.
//  Copyright © 2019 shuyu liu. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    var mapView: GMSMapView?
    
    func startReceivingLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            // User has not authorized access to location information.
            return
        }
        // Do not start services that aren't available.
        if !CLLocationManager.locationServicesEnabled() {
            // Location services is not available.
            return
        }
        // Configure and start the service.
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView = GMSMapView()
        locationManager.requestAlwaysAuthorization()
        startReceivingLocationChanges()
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings(completionHandler: { (settings) in
            guard settings.authorizationStatus == .authorized else {return}
            
            if settings.alertSetting == .enabled {
                self.scheduleNotification()
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        
        // Do something with the location.
        let lol = CLLocation.init(latitude: 43.65, longitude: -79.38)
        // setMarker(location: lol)
    }
    
    // TODO: Fix the location updates
    func setMarker(location: CLLocation) {
        let loc = CLLocation.init(latitude: 43.65, longitude: -79.38)
        
        let marker = GMSMarker()
        marker.position = loc.coordinate
        marker.title = "whatever"
        marker.map = mapView
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Check-In for you"
        content.body = "Please tell me how you feel :)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                debugPrint("Something went wrong")
            }
        }
    }

    /*
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 43.65, longitude: -79.38, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
    */
    

}

