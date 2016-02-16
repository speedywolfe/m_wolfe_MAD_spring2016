//
//  ViewController.swift
//  games-navcontroller
//
//  Created by Mitchell Wolfe on 2/15/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var gamesList = GamesClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("games", ofType: "plist")
        gamesList.GameData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        gamesList.genres = Array(gamesList.GameData.keys)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = gamesList.genres[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesList.GameData.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gamesegue" {
            let detailVC = segue.destinationViewController as! DetailTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            
            detailVC.title = gamesList.genres[indexPath.row]
            detailVC.genreListDetail = gamesList
            detailVC.selectedGenre = indexPath.row
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

