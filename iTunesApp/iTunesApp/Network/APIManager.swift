//
//  APIManager.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import Foundation
import RxSwift
import Moya

struct APIManager {
    static let shared = APIManager()
    private init() { }
    
    let provider = MoyaProvider<ITunesAPI>()
    
    func search(term: String) -> Observable<ITunesSearch> {
        
        return Observable.create { value in
            provider.request(.search(term: term)) { response in
                switch response {
                case .success(let data):
                    let result = try! JSONDecoder().decode(ITunesSearch.self, from: data.data)
                    value.onNext(result)
                case .failure(let error):
                    value.onError(error)
                
                }
            }
            
            return Disposables.create()
        }
        
        
    }
}
