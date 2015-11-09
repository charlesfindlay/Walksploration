//
//  TwitterClient.swift
//  Walksploration
//
//  Created by Student on 11/8/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

let twitterConsumerKey = "dUrsbPkEM33VdyVQylesYwQhY"
let twitterConsumerSecret = "rx0c5DtES6Z0Wniv7PCptl14OTo7UxnT0ODEZwmkjHP1zz2zVT"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    
    class var sharedInstance: TwitterClient {
        struct Static {
            
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
        }
        
        
        return Static.instance
    }
    
}
