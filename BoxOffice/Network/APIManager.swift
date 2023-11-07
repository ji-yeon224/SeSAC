//
//  APIManager.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import Foundation
import RxSwift
import Alamofire

enum APIError: Error {
    case invalidURL, unknown, statusError
}

final class APIManager {
    
    static let shared = APIManager()
    private init() { }
    
    func requestRank(api: Router) -> Observable<RankingModel> {
        return Observable<RankingModel>.create { value in
            AF.request(api).responseDecodable(of: RankingModel.self) { response in
                switch response.result {
                case .success(let data):
                    value.onNext(data)
                case .failure(_):
                    value.onError(APIError.unknown)
                }
            }
            return Disposables.create()
        }
        
        
        
    }
    
  
}
