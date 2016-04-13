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
    dynamic var name = ""
    dynamic var type = ""
    dynamic var consumed = false
    dynamic var picture : NSData?
    dynamic var id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

