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
    
    private let initialDate = DateFormatter.convertDate(date: DateFormatter.yesterdayDate())
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        
        var datepickerValue: ControlProperty<Date>
        
    }
    
    struct Output {
        
        var items: BehaviorSubject<[DailyBoxOfficeList]>
        
    }
    
    
    func format(input: Input) -> Output {
        
        
        let date: BehaviorSubject<String> = BehaviorSubject(value: initialDate)
        let result: BehaviorSubject<[DailyBoxOfficeList]> = BehaviorSubject(value: [])
        
        input.datepickerValue
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { DateFormatter.convertDate(date: $0) }
            .bind(with: self, onNext: { owner, value in
                date.onNext(value)
            })
            .disposed(by: disposeBag)
        
        date
            .flatMap {
                APIManager.shared.requestRank(api: .dailyBoxoffice(date: $0))
            }
            .bind(with: self) { owner, ranking in
                result.onNext(ranking.boxOfficeResult.dailyBoxOfficeList)
            }
            .disposed(by: disposeBag)
        
        return Output(items: result)
    }
    
}
