//
//  CheckList.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Adeline Dumas. All rights reserved.
//

import Foundation

class CheckList{
    var name : String
    var items : Array<CheckListItem>
    
    init(pName : String, pItems : Array<CheckListItem> = []) {
        self.name = pName
        self.items = pItems
    }
    

}

