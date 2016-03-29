//
//  DetailViewController.swift
//  json-data
//
//  Created by Mitchell Wolfe on 3/28/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var incomingTitle = String()
    var incomingBody = String()
    
    var detailItem: String?

    @IBOutlet weak var petitionTitle: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        detailDescriptionLabel.text? = incomingBody
        petitionTitle.text? = incomingTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

