//
//  BasicAPIManager.swift
//  SeSACRxThreads
//
//  Created by 김지연 on 11/6/23.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL, unknown, statusError
}

class BasicAPIManager {
    
    static func fetchData() -> Observable<SearchAppModel>{
        
        return Observable<SearchAppModel>.create { value in
            
            let urlString = "https://itunes.apple.com/search?term=todo&country=KR&media=software&lang=ko_KR&limit=10"
            guard let url = URL(string: urlString) else {
                // alert, completion handler
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("URLSession Succeed")
                
                if let _ = error {
                    value.onError(APIError.unknown)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(SearchAppModel.self, from: data) {
                    value.onNext(appData)
                }
            }.resume()
            
            return Disposables.create()
        }
        
    }
    
}
