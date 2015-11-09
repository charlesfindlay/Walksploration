//
//  Destination.swift
//  Walksploration
//
//  Created by Student on 11/9/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import Foundation

class Destination {
    
    let name: String
    let location: CLLocation
    var distance: Double
    
    init(name: String, location: CLLocation) {
        self.name = name
        self.location = location
        self.distance = 0.0
    }
    
}