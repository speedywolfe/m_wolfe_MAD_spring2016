//
//  Game.swift
//  games-firebase
//
//  Created by Mitchell Wolfe on 3/30/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import Foundation

class Game {
    var name: String
    var url: String
    
    init(newname: String, newurl: String) {
        name = newname
        url = newurl
    }
}