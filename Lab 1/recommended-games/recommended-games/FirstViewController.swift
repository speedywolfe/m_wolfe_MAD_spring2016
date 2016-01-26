//
//  FirstViewController.swift
//  recommended-games
//
//  Created by Mitchell Wolfe on 1/25/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var gamePicker: UIPickerView!
    
    let gameGenres = ["RPG", "Adventure", "Action", "Shooter", "Platformer", "Simulation", "Strategy", "Sports"]
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameGenres[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text = "Awesome! You like \(gameGenres[row]) games"
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameGenres.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

