//
//  SecondViewController.swift
//  recommended-games
//
//  Created by Mitchell Wolfe on 1/25/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func gameButton(sender: UIButton) {
        if(UIApplication.sharedApplication().canOpenURL(NSURL(string: "https://geo.itunes.apple.com/us/app/plants-vs.-zombies/id350642635?mt=8")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://geo.itunes.apple.com/us/app/plants-vs.-zombies/id350642635?mt=8")!)
        }
        else {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.ign.com/games/reviews")!)
        }
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

