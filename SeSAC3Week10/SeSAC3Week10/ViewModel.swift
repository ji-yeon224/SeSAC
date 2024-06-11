//
//  ViewModel.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    
    func request(completion: @escaping (URL) -> Void) {
        Network.shared.requestConvertible(type: PhotoResult.self, api: .random) { response in
            switch response {
            case .success(let success):
                dump(success)
                completion(URL(string: success.urls.thumb)!)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
}
