//
//  BeerViewModel.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation


class BeerViewModel {
    
    var beerList: Observable<BeerList> = Observable(BeerList())
    
    
    
    func fetchBeerRequest(router: BeerRouter) {
        BeerNetwork.shared.requestBeerConvertible(type: BeerList.self, api: router) { response in
            switch response {
            case .success(let success):
                self.beerList.value = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
}
