//
//  TranslateAPIManager.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager {
    
    static let shared = TranslateAPIManager()
    
    private init() { }
    
    let header: HTTPHeaders = [
        "X-Naver-Client-Id" : "\(APIKey.naverID)",
        "X-Naver-Client-Secret" : "\(APIKey.naverKey)"
    ]
    
    func callRequest(text: String, resultString: @escaping (String) -> Void ) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                resultString(data)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
