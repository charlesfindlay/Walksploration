//
//  MapViewController.swift
//  Walksploration
//
//  Created by Student on 11/3/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController, GMSMapViewDelegate {
    

    var mapView: GMSMapView!
    
    @IBOutlet weak var mapViewContainer: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(42.3367182, longitude: -83.0525951, zoom: 16)
        self.mapView = GMSMapView(frame: self.mapViewContainer.frame)
        self.mapView.camera = camera
        self.mapView.myLocationEnabled = true
        self.mapViewContainer = mapView
        self.view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(42.3358794, -83.0519393)
        marker.title = "Start"
        marker.snippet = "Grand Circus"
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
