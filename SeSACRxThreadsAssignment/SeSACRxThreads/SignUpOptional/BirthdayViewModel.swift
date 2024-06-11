//
//  BirthdayViewModel.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/2/23.
//

import Foundation
import RxSwift

class BirthdayViewModel {
    
    let birthday = BehaviorSubject<Date>(value: .now)
    let year = BehaviorSubject(value: 2023)
    let month = BehaviorSubject(value: 11)
    let day = BehaviorSubject(value: 1)
    
    let buttonEnabled = BehaviorSubject(value: false)
    let buttonColor = BehaviorSubject(value: Constants.Color.lightGray)
    
    let disposeBag = DisposeBag()
    
    
    init() {
        
        birthday
            .subscribe(with: self) { owner, date in
                let ageCheck = owner.getAge(birthday: date)
                owner.buttonColor.onNext(ageCheck ? Constants.Color.blue : Constants.Color.lightGray)
                owner.buttonEnabled.onNext(ageCheck)
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func getAge(birthday: Date) -> Bool {
        let age = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        return Int(age.year!) >= 17
    }
    
}
