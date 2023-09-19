//
//  BeerViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit

class BeerViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getResponseOneBeer()
        
        
    }

    
}

extension BeerViewController {
    func getResponseBeerList() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.beers) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getResponseRandomBeer() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.random) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getResponseOneBeer() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.single(id: 13)) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
