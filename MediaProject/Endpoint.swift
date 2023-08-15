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
    //case genre
    
    
    func requestURL(type: String) -> String {
        switch self {
        case .trend: return URL.trendEndPointString(type)
        case .credit: return URL.creditEndPointString(type)
        }
    }
    
    
    
}
