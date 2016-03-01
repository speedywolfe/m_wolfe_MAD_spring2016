//
//  SecondaryTableViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 2/29/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import RealmSwift

class SecondaryTableViewController: UITableViewController {
    
    var items = [Media]()
    var selectedCategory: Category!
    var selectedItem = 0
    var typeListDetail = Media()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
//        typeListDetail.types = Array(typeListDetail.allData.keys)
//        let chosenItem = typeListDetail.types[selectedItem]
//        items = typeListDetail.allData[chosenItem]! as [String]
        print(selectedCategory)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

//        cell.textLabel?.text = items[indexPath.row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
//        if segue.identifier == "done" {
//            let source = segue.sourceViewController as! AddItemViewController
//            if ((source.item)
//        }
//    }

    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            let chosenItem = typeListDetail.types[selectedItem]
//            typeListDetail.allData[chosenItem]?.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }

    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//        let fromRow = fromIndexPath.row
//        let toRow = toIndexPath.row
//        let moveItem = items[fromRow]
//        
//        items.removeAtIndex(fromRow)
//        items.insert(moveItem, atIndex: toRow)
//        let chosenItem = typeListDetail.types[selectedItem]
//        typeListDetail.allData[chosenItem]?.removeAtIndex(fromRow)
//        typeListDetail.allData[chosenItem]?.insert(moveItem, atIndex: toRow)
//    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
