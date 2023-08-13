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
 
    
    
//    func getTrendAPI(time: String, genre: String) -> [Movie] {
//        var contentsList: [Movie] = []
//        let url = Endpoint.trend.requestURL(genre: genre) + "\(time)"
//        var data: [JSON] = []
//        self.callRequest(url: url) { json in
//            
//            data = json["results"].arrayValue
//           
//            DispatchQueue.global().async {
//                for item in data {
//                    contentsList.append(Movie.init(title: item["title"].stringValue, overview: item["overview"].stringValue, poster: item["poster_path"].stringValue, release: item["release_date"].stringValue))
//                }
//                
//                
//            }
//            
//            
//        }
//        return contentsList
//        
//    }
    
    func callRequest(type: Endpoint, genre: String, time: String? = nil, completionHandler: @escaping (JSON) -> () ) -> [Contents] {
        var list:[Contents] = []
        var url = type.requestURL(genre: genre)
        if time != nil {
            url += "\(String(describing: time!))"
        }
        url += "?api_key=\(APIKey.tmdbKey)"
        print(url)
        
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
        return list
        
    }
    
//    func getCreditAPI(genre: String, id: Int){
//        let url = Endpoint.credit.requestURL(genre: genre) + "\(id)/credit"
//        callRequest(url: url)
//
//    }
    
    
//    func callRequest(url: String, completionHandler: @escaping (JSON) -> () ) {
//
//
//        let url = url + "?api_key=\(APIKey.tmdbKey)"
//        print(url)
//
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                completionHandler(json)
//                //print("JSON: \(json)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    
    
    
    
    
}
