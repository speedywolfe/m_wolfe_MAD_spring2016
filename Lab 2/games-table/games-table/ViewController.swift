//
//  ViewController.swift
//  games-table
//
//  Created by Mitchell Wolfe on 2/2/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var games : [String : [String]]!
    var headers : [String]!
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("games", ofType: "plist")
        games = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        headers = Array(games.keys)
        headers.sortInPlace({$0 < $1}) //Wasn't going to sort, but it looked weird otherwise
        
        let resultsController = SearchResultsController()
        resultsController.games = games
        resultsController.headers = headers
        searchController = UISearchController(searchResultsController: resultsController)
        
        searchController.searchBar.placeholder = "Enter Search"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let header = headers[section]
        let headerSection = games[header]! as [String]
        return headerSection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let header = headers[section]
        let headerSection = games[header]! as [String]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = headerSection[indexPath.row]
        cell.detailTextLabel?.text = "Replace this with something"
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headers.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    //Header names are too long so it looks dumb, plus you don't really need it with such a small amount of data
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return headers
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

