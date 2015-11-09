 //
//  DestinationJsonParser.swift
//  Walksploration
//
//  Created by Student on 11/9/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import Foundation

class DestinationJsonParser {
    
    
    /* Path for JSON files bundled with the Playground */
    var pathForDestinationJSON = NSBundle.mainBundle().pathForResource("detroitDestinations", ofType: "JSON")
    
    /* Raw JSON data (...simliar to the format you might receive from the network) */
    var rawDestinationJSON: NSData
    
    /* Error object */
    var parsingDestinationError: NSError? = nil
    
    /* Parse the data into usable form */
    var parsedDestinationJSON: NSDictionary
    
    init() {
        
        rawDestinationJSON = NSData(contentsOfFile: pathForDestinationJSON!)!
        parsedDestinationJSON = try! NSJSONSerialization.JSONObjectWithData(rawDestinationJSON, options: .AllowFragments) as! NSDictionary
    }
    
    
    
    
    
    
}