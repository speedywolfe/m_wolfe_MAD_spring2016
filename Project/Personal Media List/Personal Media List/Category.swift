//
//  Category.swift
//  Personal Media List
//
//  Created by Mitchell Wolfe on 3/1/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    dynamic var name = ""
    
    dynamic var category: Category!
}
