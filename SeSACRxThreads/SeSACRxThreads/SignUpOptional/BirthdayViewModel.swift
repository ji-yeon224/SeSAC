//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 김지연 on 11/2/23.
//

import Foundation
import RxSwift
import RxCocoa

class BirthdayViewModel {
    
    let birthday: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    let year = BehaviorRelay(value: 2020 ) //BehaviorSubject(value: 2020)
    let month = BehaviorRelay(value: 12) //BehaviorSubject(value: 12)
    let day = BehaviorRelay(value: 22) //BehaviorSubject(value: 22)
    
    let disposeBag = DisposeBag()
    
    init() {
        birthday
            .subscribe(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                owner.year.accept(component.year!)
                owner.month.accept(component.month!)
                owner.day.accept(component.day!) //owner.day.onNext(component.day!)
            } onDisposed: { owner in
                print("birthday dispose")
            }
            .disposed(by: disposeBag)
    }
    
    
}
