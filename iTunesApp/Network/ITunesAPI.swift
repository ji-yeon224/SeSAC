//
//  ITunesAPI.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import Foundation
import Moya

enum ITunesAPI {
    case search(term: String)
    
}

extension ITunesAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .search:
            return URL(string: "https://itunes.apple.com")!
        
        }
        
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }
    //?term=todo&country=KR&media=software&lang=ko_KR&limit=10
    var task: Moya.Task {
        switch self {
        case .search(let term):
            return .requestParameters(parameters: ["term": "\(term)", "country":"KR", "media":"software", "lang": "ko", "limit":"200"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .search:
            return nil
        }
    }
    
    
}
