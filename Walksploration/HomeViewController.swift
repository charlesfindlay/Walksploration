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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findDestinationButton(sender: AnyObject) {
    }
    
    @IBAction func chooseMinutesSlider(sender: AnyObject) {
        let myMinutes = round(sliderOutlet.value)
        numberMinutesLabel.text = String(myMinutes)
    }


}

