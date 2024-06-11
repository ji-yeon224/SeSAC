//
//  TMDBApi.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class TMDBApi {
    
    static let shared = TMDBApi()
    private init() { }
    static let imgURL = "https://image.tmdb.org/t/p/original"
    

    
    func callGenreRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Genre) -> ()) {
        let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Genre.self) { response in
                switch response.result {
                case .success(let value): completionHandler(value)
                case .failure(let error): print(error)
                }
            }
    }
 
    
    func callCreditRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Credits) -> ()) {
        let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Credits.self) { response in
                switch response.result {
                case .success(let value): completionHandler(value)
                case .failure(let error): print(error)
                }
            }
        
    }
    
    func callTrendingRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Contents) -> ()) {
        let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Contents.self) { response in
                switch response.result {
                case .success(let value): completionHandler(value)
                case .failure(let error): print(error)
                }
            }
    }
    
    
    
    func callVideoRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Videos) -> ()) {
        
        let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url).validate()
            .responseDecodable(of: Videos.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
                
            }
        
        
    }
    
    func callSimilarRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Similar) -> ()) {
        let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
        AF.request(url).validate()
            .responseDecodable(of: Similar.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
}
