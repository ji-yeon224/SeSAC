//
//  BeerRouter.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/22.
//

import Foundation
import Alamofire

enum BeerRouter: URLRequestConvertible {
    
    case beers
    case single(id: Int)
    case random
    
    private var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2")!
    }
    
    var path: String {
        switch self {
        case .beers:
            return "/beers"
        case .single(let id):
            return "/beers/\(id)"
        case .random:
            return"/beers/random"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
    
    
}
