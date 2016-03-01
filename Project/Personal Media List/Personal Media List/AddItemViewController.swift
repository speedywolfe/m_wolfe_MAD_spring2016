//
//  AddItemViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 3/1/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemViewController: UIViewController {
    
    var item: Media!
    
    @IBOutlet weak var nameTextField: UITextField!

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
            if ((nameTextField.text?.isEmpty) == false) {
                self.addNewItem()
            }
        }
    }
    
    func addNewItem() {
        let realm = try! Realm()
        
        try! realm.write {
            let newItem = Media()
            
            newItem.name = nameTextField.text!
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
