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
    var retrieved = try! Realm().objects(Media)
    var selectedCategory: Category!
    var categoryString : String = ""
    var selectedItem = 0
    var typeListDetail = Media()
    
    // Search stuff
    var searchController = UISearchController(searchResultsController: nil)
    var filtered = [Media]()
    
    let myGreenColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
    let myRedColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Search
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.placeholder = "Enter Search"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.scopeButtonTitles = ["All", "true", "false"]
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        retrieveData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

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
        cell.textLabel?.textColor = UIColor.whiteColor()
        if(cellItem.consumed == "true") {
            cell.backgroundColor = myGreenColor
        }
        else {
            cell.backgroundColor = myRedColor
        }
        return cell
    }
    
    // Uncomment to get side alphabetical navigation
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        let indexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
//        return indexTitles
//    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
        
        if segue.identifier == "editSave" {
            let source = segue.sourceViewController as! DetailViewController
            let changedItem = source.incomingItem
            let changedValue = source.changedConsume
            updateDataBase(changedItem, changedConsume: changedValue)
        }
    }
    
    func updateDataBase(changedItem: Media, changedConsume: String) {
        let realm = try! Realm()
        print("in update")
        
        try! realm.write {
            changedItem.consumed = changedConsume
        }
    }
    
    // reload the data from the database into the array
    func retrieveData() {
        retrieved = try! Realm().objects(Media)
        
        items.removeAll()
        for dataItem in retrieved {
            // print(dataItem)
            if(dataItem.type == categoryString) {
                items.append(dataItem)
            }
        }
        items.sortInPlace({ $0.name < $1.name })
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
        } else if editingStyle == .Insert {}
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filtered = items.filter { item in
            let categoryMatch = (scope == "All") || (item.consumed == scope)
            return categoryMatch && item.name.lowercaseString.containsString(searchText.lowercaseString)
        }        
        tableView.reloadData()
    }
}

// Extensions of main class
extension SecondaryTableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SecondaryTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
