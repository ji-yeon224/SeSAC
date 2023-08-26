//
//  Genre.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/17.
//

import Foundation

struct Genre: Codable {
    let genres: [GenreData]
}


struct GenreData: Codable {
    let id: Int
    let name: String
}
