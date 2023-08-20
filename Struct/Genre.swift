//
//  Genre.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/17.
//

import Foundation

struct GenreData: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
