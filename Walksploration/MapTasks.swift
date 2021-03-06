//
//  MapTasks.swift
//  Walksploration
//
//  Created by Student on 11/5/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit
import GoogleMaps

class MapTasks {
    
    
    let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
    var overviewPolyline: Dictionary<NSObject, AnyObject>!
    var mySteps: NSArray!

    
    
    
    
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: String, completionHandler: ((status: String, success: Bool) -> Void)) {
        
        
        let session = NSURLSession.sharedSession()
        
        if let originLocation = origin {
            if let destinationLocation = destination {
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation
                
                if let routeWaypoints = waypoints {
                    directionsURLString += "&waypoints=optimize:true"
                    
                    for waypoint in routeWaypoints {
                        directionsURLString += "|" + waypoint
                    }
                }
                
                //Set directions to walking
                directionsURLString += "&mode=walking"
                
                let url = NSURL(string: directionsURLString)!
                let request = NSURLRequest(URL: url)
                
                let task = session.dataTaskWithRequest(request) { (data, response, error) in
                    
                    /* GUARD: Was there an error? */
                    guard (error == nil) else {
                        print("There was an error with your request: \(error)")
                        completionHandler(status: "", success: false)
                        return
                    }
                    
                    /* GUARD: Did we get a successful 2XX response? */
                    guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                        if let response = response as? NSHTTPURLResponse {
                            print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                        } else if let response = response {
                            print("Your request returned an invalid response! Response: \(response)!")
                        } else {
                            print("Your request returned an invalid response!")
                        }
                        return
                    }
                    
                    /* GUARD: Was there any data returned? */
                    guard let data = data else {
                        print("No data was returned by the request!")
                        return
                    }
                    
                    /* Parse the data! */
                    let parsedResult: [String:AnyObject]!
                    do {
                        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String : AnyObject]
                    } catch {
                        parsedResult = nil
                        print("Could not parse the data as JSON: '\(data)'")
                        return
                    }
                    
                    // Check if status returned OK
                    guard let status = parsedResult["status"] as? String else {
                        print("Status not OK)")
                        return
                    }
                    
                    if status == "OK" {
                    
                        /* GUARD: Is "hits" key in our result? */
                        guard let directionResults = parsedResult["routes"] as? NSArray else {
                            print("Cannot find keys 'routes' in \(parsedResult)")
                            return
                        }
                        
                        let route = directionResults[0]
                        
                        
                        guard let legs = route["legs"] else {
                            print("no route legs")
                            return
                        }
                        
                        
                        
                        guard let steps = legs![0]["steps"] else {
                            print("no route leg steps")
                            return
                        }
                        

                        
                        // Do some stuff here
                        self.overviewPolyline = route["overview_polyline"] as! Dictionary<NSObject, AnyObject>
                        self.mySteps = steps as! NSArray
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                        }) // End dispatch_async
                        
                        
                        
                        completionHandler(status: status, success: true)
                        
                    } else {
                        completionHandler(status: status, success: false)
                    }
                    
                } // End task
                
                
                task.resume()
                
            } else {
                completionHandler(status: "Destination is nil", success: false)
            }
            
        } else {
            completionHandler(status: "Origin is nil", success: false)
        }
        
        
        
    }  // end getDirections
}
