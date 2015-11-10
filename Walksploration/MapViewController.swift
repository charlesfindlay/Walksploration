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
    

    
    @IBOutlet weak var stopWatchButton: UIButton!
    
    var mapView: GMSMapView!
    let mapTasks = MapTasks()
    var routePolyline: GMSPolyline!
    var destinations: [Destination]!
    var myLocation: CLLocation?
    var myMinutes: Int?
    var choosenDestination: Destination?
    
    @IBOutlet weak var mapViewContainer: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbvc = self.tabBarController as? TabBarController
        destinations = tbvc!.destinations
        myLocation = tbvc!.myLocation
        myMinutes =  tbvc!.myMinutes
        print(myMinutes)
        
        ConstrainMap()
        pickADestination()
        getDirectionsFromGoogle()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func stopWatchToggle(sender: AnyObject) {
        if stopWatchButton.titleLabel?.text == "Start Walk" {
            stopWatchButton.setTitle("End Walk", forState: .Normal)
            stopWatchButton.backgroundColor =  UIColor.redColor()
        } else if stopWatchButton.titleLabel?.text == "End Walk" {
            // TODO: will need anothter if statement to check for remaining walk time. If within 15% of end time then go to Facebook push. For now just implement Twitter push.
            
            let twitterAlert = UIAlertController(title: "Share with your Friends", message: "Let all your friends now about your walk on Twitter", preferredStyle: .Alert)
            let declineAction = UIAlertAction(title: "Decline", style: .Cancel, handler: nil)
            let acceptAction = UIAlertAction(title: "Accept", style: .Default, handler: { (_) -> Void in
                self.twitterHandler()
            })
            twitterAlert.addAction(declineAction)
            twitterAlert.addAction(acceptAction)
            presentViewController(twitterAlert, animated: true, completion: nil)
            stopWatchButton.enabled = false
        }
        
        
    }
    
    
    
    
    // MARK: - Utility Methods
    
    func twitterHandler() {
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "walksplorationdetroit://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("got the token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            })  { (error: NSError!) -> Void in
                print("there was an error")
                
        }
        
    }
    
    
    func pickADestination() {
        
        var best = 2000
        let maximumDistance = 85.0 * 0.45 * Double(myMinutes!) // meters per minute * less half available time
        
        for place in destinations {
            let difference = abs(Int(maximumDistance) - Int(place.distance))
            if  difference < best {
                best = difference
                choosenDestination = place
            }
        }
        print(choosenDestination?.name)
        
    }
    
    
    func getDirectionsFromGoogle() {
        
        mapTasks.getDirections("42.335890,-83.0499", destination: "42.335025,-83.059389", waypoints: nil, travelMode: "") { (status, success) -> Void in
            if success {
                print("Awesome Job!")
                dispatch_async(dispatch_get_main_queue(), {
                    self.drawRoute()
                })
                
            } else {
                print("Charles, your code sucks! Get a new career. o_O")
            }
        } // End getDirections
    }
    
    
    
    
    
    func drawRoute() {
        let route = mapTasks.overviewPolyline["points"] as! String
        
        let path: GMSPath = GMSPath(fromEncodedPath: route)
        self.routePolyline = GMSPolyline(path: path)
        routePolyline.map = mapView
    }
    
    
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
