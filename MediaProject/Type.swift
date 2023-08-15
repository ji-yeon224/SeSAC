//
//  Genre.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/13.
//

import Foundation
enum Type: String, CaseIterable {
    case all = "All"
    case movie = "Movie"
    case tv = "TV"
    //case person = "Person"
    
    var typeString: String {
        String(describing: self)
    }
     
}
