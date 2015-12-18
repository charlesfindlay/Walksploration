//
//  HomeViewController.swift
//  Walksploration
//
//  Created by Student on 11/3/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var numberMinutesLabel: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    var destinations: [Destination] = []
    let myLocation = CLLocation(latitude: 42.335890, longitude: -83.0499)
    var myMinutes = 1
    
    
    override func viewWillAppear(animated: Bool) {
        // Set destinations dictionary
        let detroitDestinations = getDestinations()
        numberMinutesLabel.text = String(myMinutes)
        
        for (key,value) in detroitDestinations {
        
            let coor = value as! [String:AnyObject]
            
            let name = key as! String
            let lat = coor["Lat"] as! Double
            let long = coor["Long"] as! Double
            let newLocation = CLLocation(latitude: lat, longitude: long)
            let newDestination = Destination(name: name, location: newLocation)
            newDestination.distance = getDistance(myLocation, nextDestination: newLocation)
            destinations.append(newDestination)
        }
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findDestinationButton(sender: AnyObject) {
        performSegueWithIdentifier("getWalkingSegue", sender: sender)
    }
    
    @IBAction func chooseMinutesSlider(sender: AnyObject) {
        let sliderMinutes = sliderOutlet.value
        myMinutes = Int(sliderMinutes)
        numberMinutesLabel.text = String(myMinutes)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "getWalkingSegue" {
            let vc = segue.destinationViewController as! TabBarController
            vc.myLocation = self.myLocation
            vc.myMinutes = self.myMinutes
            vc.destinations = self.destinations
        }
    }
    
    
    // MARK:- Utility Methods
    
    func getDestinations() -> NSDictionary {
        let parser = DestinationJsonParser()
        let destinationJson = parser.parsedDestinationJSON
        
        return destinationJson
    }
    
    func getDistance(currentLocation: CLLocation, nextDestination: CLLocation) -> Double {
        
        let newDistance = currentLocation.distanceFromLocation(nextDestination)
        
        return newDistance
    }


}