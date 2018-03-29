//
//  CheckListItem.swift
//  CheckLists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import Foundation

class CheckListItem {
    var text : String
    var checked : Bool
    
    init(pText : String, pChecked : Bool = false) {
        self.checked = pChecked
        self.text = pText
    }
    
    func toggleChecked(){
        self.checked = !self.checked;
    }
}
