//
//  TodoGame.swift
//  games-todo
//
//  Created by Mitchell Wolfe on 2/27/16.
//  Copyright © 2016 Mitchell Wolfe. All rights reserved.
//

import Foundation

class TodoGame {
    var name : String
    var reminderDate : NSDate
    var id : String
    
    init(newName : String, newReminderDate: NSDate, newId : String) {
        self.name = newName
        self.reminderDate = newReminderDate
        id = newId
    }
    
    func overDue() -> Bool {
        return (NSDate().compare(self.reminderDate) == NSComparisonResult.OrderedDescending)
    }
}
