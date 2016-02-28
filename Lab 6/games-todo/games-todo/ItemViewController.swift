//
//  ItemViewController.swift
//  games-todo
//
//  Created by Mitchell Wolfe on 2/27/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    
    var addedItem : TodoGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.delegate = self
        
        checkNotify()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            if ((itemTextField.text?.isEmpty) == false) {
                addedItem = TodoGame(newName: itemTextField.text!, newReminderDate: reminderDatePicker.date, newId: NSUUID().UUIDString)
            }
        }
    }
    
    func checkNotify() {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0 {
            let alert = UIAlertController(title: "Can't schedule notification", message: "Please go to Settings to enable notifications", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
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
