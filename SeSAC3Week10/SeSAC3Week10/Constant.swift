//
//  Constant.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/22.
//

import UIKit

enum Constant {
    
    enum Text {
        static let title = UIColor(named: "title")!
    }
    
    enum Image {
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title)
    }
    
    
}
