//
//  PhoneViewModel.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/2/23.
//

import Foundation
import RxSwift

class PhoneViewModel {
    
    let phone = BehaviorSubject(value: "010")
    let buttonEnabled = BehaviorSubject(value: false)
    let buttonColor = BehaviorSubject(value: Constants.Color.lightGray)
    let disposeBag = DisposeBag()
    
    init() {
        
        phone
            .map{ $0.count > 10 } // bool값 생성
            .subscribe(with: self) { owner, value in
                let color  = value ? Constants.Color.blue : Constants.Color.red
                owner.buttonColor.onNext(color)
                owner.buttonEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
