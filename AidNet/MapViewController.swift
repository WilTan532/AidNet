//
//  MapViewController.swift
//  AidNet
//
//  Created by shuyu liu on 2019-03-17.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 43.647, longitude: -79.379, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let senderMarker = GMSMarker()
        let senderImage = UIImage(named: "medical.jpg")!.withRenderingMode(.alwaysTemplate)
        let senderView = UIImageView(image: senderImage)
        senderView.tintColor = UIColor.red
        senderMarker.position = CLLocationCoordinate2D(latitude: 43.647, longitude: -79.379)
        // senderMarker.iconView = senderView
        senderMarker.title = "Help"
        senderMarker.snippet = "idk"
        senderMarker.map = mapView
        
        view = mapView
    }
}
