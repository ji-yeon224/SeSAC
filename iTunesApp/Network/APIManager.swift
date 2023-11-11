//
//  APIManager.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import Foundation
import Moya

struct APIManager {
    static let shared = APIManager()
    private init() { }
    
    let provider = MoyaProvider<ITunesAPI>()
    
    func search(term: String, completion: @escaping(Result<ITunesSearch, Error>) -> Void) {
        
        provider.request(.search(term: term)) { result in
            switch result {
            case .success(let data):
                let result = try! JSONDecoder().decode(ITunesSearch.self, from: data.data)
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
