//
//  AddViewController.swift
//  games-firebase
//
//  Created by Mitchell Wolfe on 3/30/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var addedgame = String()
    var addedurl = String()

    @IBOutlet weak var gamename: UITextField!
    @IBOutlet weak var gameurl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "savesegue" {
            if gamename.text?.isEmpty == false {
                addedgame = gamename.text!
                addedurl = gameurl.text!
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
