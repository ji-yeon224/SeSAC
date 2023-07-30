//
//  ShoppingList.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/29.
//

import Foundation

struct ListInfo {
    var shopping: String
    var checked: Bool
    var like: Bool
    
    mutating func setChecked(){
        self.checked = !checked
    }
    mutating func setLiked() {
        self.like = !like
    }
}
