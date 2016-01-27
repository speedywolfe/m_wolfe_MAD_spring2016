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
    
    let genreComponent = 0
    let gameComponent = 1
    
    var gameGenres : [String : [String]]!
    var genres : [String]!
    var games : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("gamegenres", ofType: "plist")
        gameGenres = NSDictionary(contentsOfFile: path!) as! [String: [String]]
        genres = Array(gameGenres.keys)
        games = gameGenres[genres[0]]! as [String]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == genreComponent {
            return genres[row]
        }
        else {
            return games[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == genreComponent {
            let selectedGenre = genres[row]
            games = gameGenres[selectedGenre]
            gamePicker.reloadComponent(gameComponent)
            gamePicker.selectRow(0, inComponent: gameComponent, animated: true)
        }
        let currentGenre = pickerView.selectedRowInComponent(genreComponent)
        let currentGame = pickerView.selectedRowInComponent(gameComponent)
        
        choiceLabel.text = "A recommended game for the \(genres[currentGenre]) genre is \(games[currentGame])"
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == genreComponent {
            return genres.count
        }
        else {
            return games.count
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

