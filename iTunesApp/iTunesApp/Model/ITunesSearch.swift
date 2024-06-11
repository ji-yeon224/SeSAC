//
//  Search.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import Foundation

struct ITunesSearch: Codable, Hashable {
    let resultCount: Int
    let results: [AppInfo]
}

// MARK: - Result
struct AppInfo: Codable, Hashable {
    let screenshotUrls: [String]
    let trackName: String // 이름
    let genres: [String] // 장르
    let trackContentRating: String // 연령제한
    let description: String // 설명
    let price: Double // 가격
    let sellerName: String // 개발자 이름
    let formattedPrice: String // 가격(무료/유료)
    let userRatingCount: Int // 평가자 수
    let averageUserRating: Double // 평균 평점
    let artworkUrl512: String // 아이콘 이미지
    let languageCodesISO2A: [String] // 언어 지원
    let trackId: Int
    let version: String
    let releaseNotes: String?
}


