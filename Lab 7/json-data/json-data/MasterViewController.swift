//
//  MasterViewController.swift
//  json-data
//
//  Created by Mitchell Wolfe on 3/28/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [[String:String]]()


    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let petition = objects[indexPath.row]
                let petitiontitle = petition["title"]
                let body = petition["body"]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.incomingBody = body!
                controller.incomingTitle = petitiontitle!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"]
        if object["signature"] != nil {
            cell.detailTextLabel!.text = object["signature"]! + " Signatures Needed"
        }
        return cell
    }
    
    func loadjson() {
        let urlPath = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
        guard let url = NSURL(string: urlPath)
            else {
                print("url error")
                return
        }
        
        let session = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {(data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            print("download successful")
            dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
        })
        session.resume()
    }
    
    func parsejson(data: NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let allresults = json["results"] as! NSArray
            let results = Array(allresults)
            
            for result in results {
                guard let title = result["title"]! as? String,
                    let sigCount = result["signaturesNeeded"] as? NSNumber,
                    let itembody = result["body"]! as? String
                    else {
                        continue
                }
                
                let obj = ["title":title, "signature": sigCount.stringValue, "body": itembody]
                self.objects.append(obj)
            }
        }
        catch {
            print("Error with JSON: \(error)")
        }
        tableView.reloadData()
    }
}

