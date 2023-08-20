//
//  Endpoint.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation

enum Endpoint: String {
    case trend
    case credit
    case genre
    case similar
    case videos
    
    
    func requestURL(type: String) -> String {
        switch self {
        case .trend: return URL.makeEndPointString("trending/\(type)")
        case .credit: return URL.makeEndPointString("\(type)")
        case .genre: return URL.makeEndPointString("genre/\(type)/list")
        case .similar: return URL.makeEndPointString("\(type)/similar")
        case .videos: return URL.makeEndPointString("\(type)/videos") //id
        }
    }
    
    
    
}
