//
//  PunkAPI.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation
import Alamofire

enum PunkAPI {
    
    case beers
    case single(id: Int)
    case random
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2"
    }
    
    var endPoint: URL {
        switch self {
        case .beers:
            return URL(string: baseURL + "/beers")!
        case .single(let id):
            return URL(string: baseURL + "/beers/\(id)")!
        case .random:
            return URL(string: baseURL + "/beers/random")!
        }
    }
    
}
