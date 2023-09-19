//
//  BeerNetwork.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation
import Alamofire

class BeerNetwork {
    
    static let shared = BeerNetwork()
    
    private init() { }
    
    func requestBeer<T: Decodable>(type: T.Type, api: PunkAPI, completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(api.endPoint, method: .get).responseDecodable(of: T.self) { response in
            print(response)
            switch response.result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
}
