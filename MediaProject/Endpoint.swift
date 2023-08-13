//
//  Endpoint.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation

enum Endpoint {
    case trend
    case credit
    
    
    func requestURL(genre: String) -> String {
        switch self {
        case .trend: return URL.trendEndPointString(genre)
        case .credit: return URL.creditEndPointString(genre)
        }
    }
    
    
    
}
