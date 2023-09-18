//
//  Random.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import Foundation


struct Random: Codable {
    
    let id: String
    let urls: Urls?
    let likes: Int
  
}


struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb : String

}


