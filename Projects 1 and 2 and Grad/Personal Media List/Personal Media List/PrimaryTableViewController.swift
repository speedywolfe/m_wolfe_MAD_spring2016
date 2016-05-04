//
//  PrimaryTableViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 2/29/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import RealmSwift

class PrimaryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories = [Category]()
    var retrievedCategories = try! Realm().objects(Category)
    var selectedCategory: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        populateInitialCategories()
        
        //If you want path for realm database then uncomment this:
        //print(Realm.Configuration.defaultConfiguration.path!)
        
        //put in viewDidLoad()
//        func designUI(){
//            navigationController?.navigationBar.barTintColor = UIColor.customGreenColor()
//            navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//            navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
//            navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.peachColor(), NSFontAttributeName: UIFont(name: "GrandHotel-Regular", size: 26)! ]
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        retrieveData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* http://www.raywenderlich.com/112544/realm-tutorial-getting-started */
    func populateInitialCategories() {
        if categories.count == 0 {
            
            try! realm.write() {
                
                let defaultCategories = ["Movies", "TV Shows", "Games", "Books"]
                
                for category in defaultCategories {
                    let newCategory = Category()
                    newCategory.name = category
                    self.realm.add(newCategory)
                }
            }
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedCategory = categories[indexPath.row]
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "primary_to_secondary" {
            let detailVC = segue.destinationViewController as! SecondaryTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            let category = categories[indexPath!.row]
            detailVC.title = category.name
            detailVC.categoryString = category.name
            
            detailVC.selectedCategory = selectedCategory
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let realm = try! Realm()
        
        if segue.identifier == "saveList" {
            let source = segue.sourceViewController as! AddListViewController
            try! realm.write {
                let newCategory = source.categoryToAdd
                realm.add(newCategory)
            }
        }
    }
    
    // reload the data from the database into the array
    func retrieveData() {
        retrievedCategories = try! Realm().objects(Category)
        
        categories.removeAll()
        for item in retrievedCategories {
            categories.append(item)
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let realm = try! Realm()
        
        if editingStyle == .Delete {
            let chosenCategory = categories[indexPath.row]
            categories.removeAtIndex(indexPath.row)
            try! realm.write {
                realm.delete(chosenCategory)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
