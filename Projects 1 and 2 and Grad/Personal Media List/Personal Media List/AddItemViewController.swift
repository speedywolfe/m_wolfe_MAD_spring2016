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
    
    @IBOutlet weak var databaseLabel: UILabel!
    @IBOutlet weak var databaseTextField: UITextField!
    @IBOutlet weak var manualLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        addInfoLabel.text? = "Add new \(incomingType)"
        print(incomingType)
        if(incomingType != "Movies") {
            databaseLabel.hidden = true
            databaseTextField.hidden = true
            manualLabel.hidden = true
        }
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
    
    @IBAction func searchDatabase(sender: UIButton) {
        if((databaseTextField.text?.isEmpty) == false) {
            let inputText = databaseTextField.text!
            let formattedText = inputText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            loadjson(formattedText!)
        }
    }
    func loadjson(search: String) {
        let urlPath = NSURL(string:"http://www.omdbapi.com/?t=" + search + "&y=&plot=short&r=json")!
        let session = NSURLSession.sharedSession().dataTaskWithURL(urlPath) {
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
        }
        session.resume()
    }
    
    func parsejson(data: NSData) {
        let json = JSON(data: data)
        let name = json["Title"].stringValue
        let imageString = json["Poster"].stringValue
        let imageURL = NSURL(string: imageString)
        self.nameTextField.text = name
        let imageData = NSData(contentsOfURL: imageURL!)
        self.imageDisplay.image = UIImage(data: imageData!)
        print(name)
    }
}
