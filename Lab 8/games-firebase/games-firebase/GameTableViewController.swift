//
//  GameTableViewController.swift
//  games-firebase
//
//  Created by Mitchell Wolfe on 3/30/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import Firebase

class GameTableViewController: UITableViewController {
    let ref = Firebase(url: "https://mwolfe-games.firebaseio.com")
    var games = [Game]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.observeEventType(FEventType.Value, withBlock: {snapshot in
            self.games=[]
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for item in snapshots {
                    guard let gameName = item.value["name"] as? String,
                    let gameUrl = item.value["url"] as? String
                        else {
                            continue
                    }
                    let newGame = Game(newname: gameName, newurl: gameUrl)
                    self.games.append(newGame)
                }
            }
            self.tableView.reloadData()
        })
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
        return games.count
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "savesegue" {
            let source = segue.sourceViewController as! AddViewController
            if source.addedgame.isEmpty == false {
                let newGame = Game(newname: source.addedgame, newurl: source.addedurl)
                games.append(newGame)
                let newGameDict = ["name": source.addedgame, "url": source.addedurl]
                let gameref = ref.childByAppendingPath(source.addedgame)
                gameref.setValue(newGameDict)
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gamecell", forIndexPath: indexPath)

        let game = games[indexPath.row]
        cell.textLabel!.text = game.name

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let recipe = games[indexPath.row]
            let reciperef = ref.childByAppendingPath(recipe.name)
            reciperef.ref.removeValue()
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
