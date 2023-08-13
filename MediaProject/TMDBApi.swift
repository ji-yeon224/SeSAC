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

    func trendCallRequest(type: Endpoint, genre: String, time: String? = nil, completionHandler: @escaping (JSON) -> () ) {
        
        var url = type.requestURL(genre: genre)
        if time != nil {
            url += "\(String(describing: time!))"
        }
        url += "?api_key=\(APIKey.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func creditCallRequest(genre: String, id: Int, completionHandler: @escaping (JSON) -> () ) {
        
        var url = Endpoint.credit.requestURL(genre: genre) + "/\(id)/credits"
        url += "?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json)
                //print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
    
    
    
    
}
