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
    @IBOutlet weak var searchButton: UIButton!
    
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
            searchButton.hidden = true
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
                else {
                    let defaultImage = UIImage(named: "default_icon")
                    let imageData : NSData = UIImagePNGRepresentation(defaultImage!)!
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
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("error download file")
                    return
            }
            
            print("download successful")
            dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
        }
        session.resume()
    }
    
    func parsejson(data: NSData) {
        let json = JSON(data: data)
        print(json)
        if(json["Response"].stringValue == "False") {
            let alert1 =  UIAlertController(title: "Doesn't Exist", message: "This movie is not in the database, please try again", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .Default) { (action) in }
            alert1.addAction(cancelAction)
            presentViewController(alert1, animated: true, completion: nil)
        }
        else {
            let name = json["Title"].stringValue
            self.nameTextField.text = name
            if(json["Poster"].stringValue != "N/A") {
                let imageString = json["Poster"].stringValue
                let imageURL = NSURL(string: imageString)
                let imageData = NSData(contentsOfURL: imageURL!)
                self.imageDisplay.image = UIImage(data: imageData!)
                print(name)
            }
        }
    }
}
