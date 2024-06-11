//
//  Setting.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/16.
//

import UIKit


struct Setting: Hashable {
    
    let icon: String?
    let title: String
    
    init(icon: String?, title: String) {
        self.icon = icon
        self.title = title
    }
    
}
