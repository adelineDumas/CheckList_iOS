//
//  CheckList.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import Foundation
import UIKit

class CheckList : Codable{
    var name : String
    var items : Array<CheckListItem>
    var icon : IconAsset
    
    var uncheckedItemsCount : Int {
        return items.filter{ !$0.checked }.count
    }
    
    init(pName : String, pItems : Array<CheckListItem> = [], icon : IconAsset) {
        self.name = pName
        self.items = pItems
        self.icon = icon
    }
}

enum IconAsset : String, Codable{
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}
