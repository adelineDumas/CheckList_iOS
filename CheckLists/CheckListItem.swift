//
//  CheckListItem.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import Foundation

class CheckListItem : Codable{
    var text : String
    var checked : Bool
    var dueDate : Date = Date()
    var shouldRemind : Bool = false
    var itemId : Int = 0
    
    init(pText : String, pChecked : Bool = false, pDate : Date = Date(), pShouldRemind : Bool = false) {
        self.checked = pChecked
        self.text = pText
        self.dueDate = pDate
        self.shouldRemind = pShouldRemind
        self.itemId = Preferences.sharedInstance.nextCheckListItemID()
    }
    
    init(pText : String, pChecked : Bool = false, pDate : Date = Date(), pShouldRemind : Bool = false, pItemId : Int) {
        self.checked = pChecked
        self.text = pText
        self.dueDate = pDate
        self.shouldRemind = pShouldRemind
        self.itemId = pItemId
    }
    
    
    func toggleChecked(){
        self.checked = !self.checked;
    }
    
}
