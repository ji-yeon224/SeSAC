//
//  LottoAPI.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/13.
//

import Foundation
import Alamofire

class LottoAPI {
    
    static let shared = LottoAPI()
    private init() { }
    
    func lottoNumRequest(drwNo: String, handler: @escaping (Lotto) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: Lotto.self) { response in
                
                switch response.result {
                case .success(let data): handler(data)
                case .failure(let error): print(error)
                }
                
            }
        
    }
    
    
    
}
