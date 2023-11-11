//
//  SearchViewModel.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    
    var data: [AppInfo] = []
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButton: ControlEvent<Void>
        let searchText: ControlProperty<String>
        
    }
    
    struct Output {
        let items: BehaviorRelay<[AppInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let result: BehaviorRelay<[AppInfo]> = BehaviorRelay(value: [])
        
        input.searchButton
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText) { _, text in
                return text
            }
            .map{ return "\($0)" }
            .distinctUntilChanged()
            .flatMap { term in
                APIManager.shared.search(term: term )
                    .asDriver(onErrorJustReturn: ITunesSearch(resultCount: 0, results: []))
            }
            .subscribe(with: self) { owner, value in
                owner.data.removeAll()
                owner.data.append(contentsOf: value.results)
                result.accept(owner.data)
                //owner.updateSnapShot()
            }
            .disposed(by: disposeBag)
        
        return Output(items: result)
        
        
    }
    
    
    
    
}
