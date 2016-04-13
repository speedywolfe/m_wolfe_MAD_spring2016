//
//  DetailViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 2/29/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    var incomingItem = Media()
    var changedConsume = Bool()

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var consumedSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        itemName.text? = incomingItem.name
        let decoded : UIImage = UIImage(data: incomingItem.picture!)!
        itemImage.image = decoded
        changedConsume = incomingItem.consumed
        if(incomingItem.consumed == true) {
            consumedSegmentControl.selectedSegmentIndex = 0
        }
        else {
            consumedSegmentControl.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editSave" {
            print("detail prepare for segue")
            var newConsumed = Bool()
            if(consumedSegmentControl.selectedSegmentIndex == 0) {
                newConsumed = true
            }
            else {
                newConsumed = false
            }
            changedConsume = newConsumed
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
