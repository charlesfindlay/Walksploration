//
//  MapViewController.swift
//  Walksploration
//
//  Created by Student on 11/3/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    

    var mapView: GMSMapView!
    let mapTasks = MapTasks()
    
    @IBOutlet weak var mapViewContainer: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstrainMap()
        mapTasks.getDirections("42.335890,-83.0499", destination: "42.332271,-83.0468119", waypoints: nil, travelMode: "") { (status, success) -> Void in
            if success {
                print("Awesome Job!")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Utility Methods
    
    func ConstrainMap() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(42.335890, longitude: -83.0499, zoom: 16)
        self.mapView = GMSMapView(frame: self.mapViewContainer.frame)
        self.mapView.camera = camera
        self.mapView.myLocationEnabled = true
        self.mapViewContainer = mapView
        self.view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(42.335890, -83.0499)
        marker.title = "Start"
        marker.snippet = "Grand Circus"
        marker.map = mapView
        
        mapViewContainer.backgroundColor = UIColor(red: 135/255, green: 222/255, blue: 212/255, alpha: 1)
        // add subview before adding constraints
        self.view.addSubview(mapViewContainer)
        
        // essential to apply NSLayoutConstraints programatically
        mapViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // trailing margin constraint
        let const1 = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: mapViewContainer, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -10)
        // top constraint
        let const2 = NSLayoutConstraint(item: mapViewContainer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:topLayoutGuide, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        // bottom constraint
        let const3 = NSLayoutConstraint(item: bottomLayoutGuide, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem:mapViewContainer, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 150)
        // leading margin constraint
        let const4 = NSLayoutConstraint(item: mapViewContainer, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:self.view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: -15)
        
        NSLayoutConstraint.activateConstraints([const1, const2, const3, const4])
        
        
    }
    
    
}
