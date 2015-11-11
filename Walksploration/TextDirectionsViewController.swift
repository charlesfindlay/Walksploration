//
//  TextDirectionsViewController.swift
//  Walksploration
//
//  Created by Student on 11/10/15.
//  Copyright © 2015 Charles Findlay. All rights reserved.
//

import UIKit

class TextDirectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var textDirectionsTable: UITableView!
    
    var textDirections: [String] = []
    
    override func viewWillAppear(animated: Bool) {
        let tbvc = self.tabBarController as? TabBarController
        self.textDirections = (tbvc?.textDirections)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textDirections.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("directionTextCell")
        let nextDir = textDirections[indexPath.row] 
        let htmlFormattedDirections = try! NSAttributedString(
            data: nextDir.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        cell?.textLabel?.attributedText = htmlFormattedDirections
        
        //cell!.textLabel?.text = nextDir

        

        return cell!
    }

}
