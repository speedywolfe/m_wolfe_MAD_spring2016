//
//  AddGameViewController.swift
//  games-navcontroller
//
//  Created by Mitchell Wolfe on 2/15/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {

    @IBOutlet weak var gameTextField: UITextField!
    var addedGame = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneSegue" {
            if ((gameTextField.text?.isEmpty) == false) {
                addedGame = gameTextField.text!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
