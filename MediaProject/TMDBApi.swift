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

    func callRequest(endPoint: Endpoint, parameter: String, completionHandler: @escaping (JSON) -> ()) {
            
        //let data = "\(endPoint.rawValue)"
            let url = endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)"
            print(url)
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //print(json)
                    completionHandler(json)
                case .failure(let error):
                    print(error)
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
    
}
