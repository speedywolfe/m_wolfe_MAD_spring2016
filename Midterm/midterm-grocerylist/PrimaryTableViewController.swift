//
//  PrimaryTableViewController.swift
//  midterm-grocerylist
//
//  Created by Mitchell Wolfe on 3/10/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class PrimaryTableViewController: UITableViewController {
    var storeList = Stores()
    let kfilename = "data.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        let path:String?
        let filePath = docFilePath(kfilename)
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!){
            path = filePath
            print(path)
        }
        else {
            path = NSBundle.mainBundle().pathForResource("stores", ofType: "plist")
            print(path)
        }
        
        storeList.storeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        storeList.stores = Array(storeList.storeData.keys)
        
        let app = UIApplication.sharedApplication()
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return storeList.storeData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

         cell.textLabel?.text = storeList.stores[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "storesegue" {
            let detailVC = segue.destinationViewController as! SecondaryTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            
            detailVC.title = storeList.stores[indexPath.row]
            detailVC.storeListDetail = storeList
            detailVC.selectedStore = indexPath.row
        }
    }
    
    func docFilePath(filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString
        return dir.stringByAppendingPathComponent(filename)
    }
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntriesFromDictionary(storeList.storeData)
        data.writeToFile(filePath!, atomically: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
