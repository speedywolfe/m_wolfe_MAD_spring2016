//
//  AddItemViewController.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 3/1/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var itemToAdd: Media!
    var incomingType : String = ""
    var isConsumed = "false"
    
    @IBOutlet weak var addInfoLabel: UILabel!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var segmentPicker: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print(incomingType)
        addInfoLabel.text? = "Add new \(incomingType)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            if ((nameTextField.text?.isEmpty) == false) {
                let newItem = Media()
                newItem.name = nameTextField.text!
                newItem.id = nameTextField.text!
                newItem.type = incomingType
                if(imageDisplay.image != nil) {
                    let imageData : NSData = UIImagePNGRepresentation(imageDisplay.image!)!
                    newItem.picture = imageData
                }
                if(segmentPicker.selectedSegmentIndex == 0) {
                    isConsumed = "true"
                    newItem.consumed = isConsumed
                }
                itemToAdd = newItem
            }
        }
    }
    
    // Got help with the photo stuff from: https://www.youtube.com/watch?v=YYS-LwvluL8 by user MstCode
    @IBAction func photoButton(sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //print(imgPicker)
        presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageDisplay.image = image
        print(image)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
