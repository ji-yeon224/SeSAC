//
//  BoxOfficeViewModel.swift
//  SeSACRxSummery
//
//  Created by 김지연 on 11/8/23.
//

import Foundation
import RxSwift
import RxCocoa
class BoxOfficeViewModel: ViewModelType {
    
    var recent = ["테스트 4", "테스트 5", "테스트 6"]
    
    struct Input {
        
        let searchButtonTap: ControlEvent<Void> // searchBar.rx.searchButtonClicked
        let searchText: ControlProperty<String> // searchBar.rx.text.orEmpty
        let recentText: PublishSubject<String>
    }
    
    struct Output {
        
        let recent: BehaviorRelay<[String]>
        let items: PublishSubject<[DailyBoxOfficeList]>
        
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let boxOfficeList = PublishSubject<[DailyBoxOfficeList]>()
        let recentList = BehaviorRelay(value: recent)
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText, resultSelector: { _, value in
                return value
            })
            .map { text -> String in
                guard let newText = Int(text) else { return "20231106" }
                return String(newText)
            }
            .flatMap {
                BoxOfficeNetwork.fetchBoxOfficeData(date: $0)
            }
            .subscribe(with: self, onNext: { owner, movie in
                let data = movie.boxOfficeResult.dailyBoxOfficeList
                boxOfficeList.onNext(data)
            })
            .disposed(by: disposeBag)
        
        input.recentText
            .subscribe(with: self) { owner, value in
                owner.recent.append(value)
                recentList.accept(owner.recent)
            }
            .disposed(by: disposeBag)
        
        
        return Output(recent: recentList, items: boxOfficeList)
    }
    
}
