//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/17.
//

import Foundation

struct Recommendation: Codable {
    let page: Int
    let results: [Movie]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Movie: Codable {
    let originalTitle: String
    let voteCount: Int
    let popularity: Double
    let id: Int
    let voteAverage: Double
    let mediaType: MediaType
    let releaseDate: String
    let adult: Bool
    let posterPath, backdropPath: String?
    let genreIDS: [Int]
    let video: Bool
    let originalLanguage: String
    let title, overview: String

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case voteCount = "vote_count"
        case popularity, id
        case voteAverage = "vote_average"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case adult
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case video
        case originalLanguage = "original_language"
        case title, overview
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

