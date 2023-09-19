//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//        NetworkBasic.shared.random { photo, error in
//            guard let photo = photo else { return }
//        }
        
//        NetworkBasic.shared.detailPhoto(id: "") { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        
        Network.shared.request(type: PhotoResult.self, api: .photo(id: "JQuR91mrD20")) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
        
        
        
    }
 

}

struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
    
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
