//
//  KakaoAPIManager.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    private init() { }
    
    let header: HTTPHeaders =  ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (Video) -> () ) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = type.requestURL + text

        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: Video.self) { response in
            
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                print(error)
            }
            

        }
        
        
        

        
        
        
        
    }
    
}
