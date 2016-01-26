//
//  SecondViewController.swift
//  recommended-games
//
//  Created by Mitchell Wolfe on 1/25/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var gamePicker: UIPickerView!
    
    let charactersOne = ["Mario", "Link", "Donkey Kong", "Samus"]
    let charactersTwo = 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

