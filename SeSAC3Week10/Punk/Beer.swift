//
//  Beer.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation


struct BeerResult: Decodable {
    let id: Int
    let name: String
    let imageURL: String


    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
       
    }
}

typealias Beer = [BeerResult]


