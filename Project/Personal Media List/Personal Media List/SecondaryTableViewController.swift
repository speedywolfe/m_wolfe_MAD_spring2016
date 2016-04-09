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
    let indexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    var retrieved = try! Realm().objects(Media)
    var selectedCategory: Category!
    var categoryString : String = ""
    var selectedItem = 0
    var typeListDetail = Media()
    
    // Search stuff
    var searchController = UISearchController(searchResultsController: nil)
    var filtered = [Media]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "Enter Search"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        retrieveData()
        tableView.reloadData()
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
        if searchController.active && searchController.searchBar.text != "" {
            return filtered.count
        }
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let cellItem: Media
        
        if searchController.active && searchController.searchBar.text != "" {
            cellItem = filtered[indexPath.row]
        }
        else {
            cellItem = items[indexPath.row]
        }

        cell.textLabel?.text = cellItem.name

        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return indexTitles
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Send object to detailview to show info for media
        if segue.identifier == "detail" {
            let detailVC = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)

            if searchController.active && searchController.searchBar.text != "" {
                let data = filtered[indexPath!.row]
                detailVC.title = data.name
                detailVC.incomingItem = data
            }
            else {
                let data = items[indexPath!.row]
                detailVC.title = data.name
                detailVC.incomingItem = data
            }
        }
        
        if segue.identifier == "add" {
            let navVC = segue.destinationViewController as! UINavigationController
            let addVC = navVC.topViewController as! AddItemViewController
            
            addVC.incomingType = categoryString
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let realm = try! Realm()
        
        if segue.identifier == "save" {
            let source = segue.sourceViewController as! AddItemViewController
            if (source.itemToAdd != nil) {
                try! realm.write {
                    let addedItem = source.itemToAdd
                    realm.add(addedItem)
                }
            }
        }
    }
    
    // reload the data from the database into the array
    func retrieveData() {
        retrieved = try! Realm().objects(Media)
        
        items.removeAll()
        for dataItem in retrieved {
            print(dataItem)
            if(dataItem.type == categoryString) {
                items.append(dataItem)
            }
        }
        items.sortInPlace({$0.name < $1.name })
    }

     //Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let realm = try! Realm()
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            let chosenItem = items[selectedItem]
            items.removeAtIndex(indexPath.row)
            try! realm.write {
                realm.delete(chosenItem)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filtered = items.filter { item in
            return item.name.lowercaseString.containsString(searchText.lowercaseString)
        }        
        tableView.reloadData()
    }
    
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

//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondaryTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
