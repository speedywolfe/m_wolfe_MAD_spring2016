//
//  AddItemViewController.swift
//  midterm-grocerylist
//
//  Created by Mitchell Wolfe on 3/10/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var addedItem = String()
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            if((textField.text?.isEmpty) == false) {
                addedItem = textField.text!
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
