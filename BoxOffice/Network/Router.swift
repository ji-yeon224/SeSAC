//
//  Router.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    
    case dailyBoxoffice(date: String)
    
    private var baseURL: URL {
        switch self {
        case .dailyBoxoffice: return URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json")!
        }
    }
    
    private var header: HTTPHeaders {
        switch self {
        case .dailyBoxoffice: ["Content-Type": "application/json"]
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .dailyBoxoffice: return .get
        }
    }
    
     
    private var query: [String: String] {
        switch self {
        case .dailyBoxoffice(let date):
            return ["key":"\(APIKey.key)", "targetDt":"\(date)"]
        
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        
        let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var request = URLRequest(url: urlComponent.url!)
        request.headers = header
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        
        return request
    }
    
    
    
}
