//
//  RankViewModel.swift
//  BoxOffice
//
//  Created by 김지연 on 11/8/23.
//

import Foundation
import RxSwift
import RxCocoa

final class RankViewModel {
    
    var data: [DailyBoxOfficeList] = []
    lazy var items = BehaviorSubject(value: data)
    
    var date = BehaviorRelay(value: DateFormatter.convertDate(date: Date()))
    lazy var request = APIManager.shared.requestRank(api: .dailyBoxoffice(date: date.value))
        .asDriver(onErrorJustReturn: RankingModel(boxOfficeResult: Results( dailyBoxOfficeList: [])))
   
    let disposeBag = DisposeBag()
    
    init() {
        
        request
            .drive(with: self) { owner, result in
                owner.data.append(contentsOf: result.boxOfficeResult.dailyBoxOfficeList)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        date
            .flatMap {
                APIManager.shared.requestRank(api: .dailyBoxoffice(date: $0))
            }
            .bind(with: self) { owner, ranking in
                owner.data.removeAll()
                owner.data.append(contentsOf: ranking.boxOfficeResult.dailyBoxOfficeList)
                owner.items.onNext(owner.data)
                
            }
            .disposed(by: disposeBag)
    }
    
    
}
