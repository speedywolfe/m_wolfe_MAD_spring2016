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
    let filename = "data.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path:String?
        let filePath = docFilePath(filename)
        
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!) {
            path = filePath
        }
        else {
            path = NSBundle.mainBundle().pathForResource("games", ofType: "plist")
        }
        
        gamesList.GameData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        gamesList.genres = Array(gamesList.GameData.keys)
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
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
        else if segue.identifier == "gameInfoSegue" {
            let infoVC = segue.destinationViewController as! GameInfoTableViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(editingCell)
            infoVC.name = gamesList.genres[indexPath!.row]
            let games = gamesList.GameData[infoVC.name]! as [String]
            infoVC.number = String(games.count)
        }
    }
    
    func docFilePath(filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString
        return dir.stringByAppendingPathComponent(filename)
    }
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(filename)
        let data = NSMutableDictionary()
        data.addEntriesFromDictionary(gamesList.GameData)
        print(data)
        data.writeToFile(filePath!, atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

