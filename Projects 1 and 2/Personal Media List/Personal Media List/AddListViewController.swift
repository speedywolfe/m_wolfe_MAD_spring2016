//
//  AddListViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 4/13/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController {
    
    
    @IBOutlet weak var listTextField: UITextField!

    var categoryToAdd: Category!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveList" {
            if ((listTextField.text?.isEmpty) == false) {
                let tempCategory = Category()
                tempCategory.name = listTextField.text!
                categoryToAdd = tempCategory
            }
        }
    }
}
