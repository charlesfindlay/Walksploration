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
    let lat: Double
    let long: Double
    let distance: Double
    
    init(name: String, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
        self.distance = 0.0
    }
    
}