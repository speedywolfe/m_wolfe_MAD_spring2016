//
//  DetailTableViewController.swift
//  games-navcontroller
//
//  Created by Mitchell Wolfe on 2/15/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var games = [String]()
    var selectedGenre = 0
    var genreListDetail = GamesClass()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        genreListDetail.genres = Array(genreListDetail.GameData.keys)
        let chosenGenre = genreListDetail.genres[selectedGenre]
        games = genreListDetail.GameData[chosenGenre]! as [String]
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
        return games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = games[indexPath.row]
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
            games.removeAtIndex(indexPath.row)
            let chosenGenre = genreListDetail.genres[selectedGenre]
            genreListDetail.GameData[chosenGenre]?.removeAtIndex(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fromRow = fromIndexPath.row
        let toRow = toIndexPath.row
        let moveGame = games[fromRow]
        
        games.removeAtIndex(fromRow)
        games.insert(moveGame, atIndex: toRow)
        let chosenGenre = genreListDetail.genres[selectedGenre]
        genreListDetail.GameData[chosenGenre]?.removeAtIndex(fromRow)
        genreListDetail.GameData[chosenGenre]?.insert(moveGame, atIndex: toRow)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "doneSegue" {
            let source = segue.sourceViewController as! AddGameViewController
            if ((source.addedGame.isEmpty) == false) {
                games.append(source.addedGame)
                tableView.reloadData()
                let chosenGenre = genreListDetail.genres[selectedGenre]
                genreListDetail.GameData[chosenGenre]?.append(source.addedGame)
            }
        }
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
