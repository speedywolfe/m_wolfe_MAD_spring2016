//
//  Media.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 2/29/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import Foundation
import RealmSwift

class Media: Object {
    var name = ""
    
    func returnName() -> String {
        return name
    }
//    dynamic var allData = [String : [String]]()
//    dynamic var types = [String]()
}
