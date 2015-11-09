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
    
    var detroitDestinations = NSDictionary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set destinations dictionary
        detroitDestinations = getDestinations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findDestinationButton(sender: AnyObject) {
        performSegueWithIdentifier("getWalkingSegue", sender: sender)
    }
    
    @IBAction func chooseMinutesSlider(sender: AnyObject) {
        let myMinutes = round(sliderOutlet.value)
        numberMinutesLabel.text = String(myMinutes)
    }
    
    
    // MARK:- Utility Methods
    
    func getDestinations() -> NSDictionary {
        let parser = DestinationJsonParser()
        let destinationJson = parser.parsedDestinationJSON
        print(destinationJson.count)
        
        return destinationJson
    }


}

