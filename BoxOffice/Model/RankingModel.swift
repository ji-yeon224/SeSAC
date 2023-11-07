//
//  RankingModel.swift
//  BoxOffice
//
//  Created by 김지연 on 11/7/23.
//

import Foundation

struct RankingModel: Codable {
    let boxOfficeResult: Results
}

// MARK: - BoxOfficeResult
struct Results: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: String
    let movieCD, title, openDt: String
    let audiCnt, audiInten, audiChange, audiAcc: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case title = "movieNm"
        case openDt, audiCnt, audiInten, audiChange, audiAcc
    }
}

