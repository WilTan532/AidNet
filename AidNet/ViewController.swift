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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var onClickDispatchButton: UIButton!
    
    @IBOutlet weak var onClickMapButton: UIButton!
    
    @IBAction func onClickDispatchButtonAction(_ sender: UIButton) {
        let confirm = UIAlertController(title: "Confirm", message: "Are you sure you want to ask for help?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            EventDispatcher().dispatch()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: { (action) -> Void in
            
        })
        
        confirm.addAction(ok)
        confirm.addAction(cancel)
        self.present(confirm, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickMapButtonAction(_ sender: UIButton) {
        let confirm = UIAlertController(title: "Confirm", message: "Do you want to help?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            let mapViewController = MapViewController()
            NotificationClient().push(title: "Alert", body: "AIDEE is on the way")
            self.present(mapViewController, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: { (action) -> Void in
            
        })
        
        confirm.addAction(ok)
        confirm.addAction(cancel)
        self.present(confirm, animated: true, completion: nil)
    }
    
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
        
        // Testing code
        let dispatcher = EventDispatcher()
        let db = DatabaseController()
        db.listenForEventAndNotify()
        // dispatcher.dispatch()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        
        // Do something with the location.
        let lol = CLLocation.init(latitude: 43.65, longitude: -79.38)
    }

}

