//
//  VideoStruct.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/16.
//

import Foundation

struct Video: Codable {
    var documents: [Document]
}

//// MARK: - Document
struct Document: Codable {
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime
        case playTime = "play_time"
        case thumbnail, title, url
    }
    
    //연산 프로퍼티
    var contents: String {
        get {
            return "\(author) | \(playTime)회\n\(datetime)"
        }
    }
}



struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
