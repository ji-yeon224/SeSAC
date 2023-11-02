//
//  ValidationViewModel.swift
//  RxSwiftPractice
//
//  Created by 김지연 on 11/3/23.
//

import Foundation
import RxSwift

class ValidationViewModel {
    
    let usernameLabelHidden = BehaviorSubject(value: false)
    let passwordLabelHidden = BehaviorSubject(value: false)
    let passwordTextFieldEnabled = BehaviorSubject(value: true)
    let userNameValid = BehaviorSubject(value: false)
    let passwordValid = BehaviorSubject(value: false)
    let checkButtonEnabled = BehaviorSubject(value: true)
    var totalValidation = Observable.of(false)
    
    let disposeBag = DisposeBag()
    
    init() {
        totalValidation = Observable.combineLatest(userNameValid, passwordValid) {
            return $0 && $1
        }
       
        userNameValid
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.usernameLabelHidden.onNext(value)
                owner.passwordTextFieldEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
        
        passwordValid
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.passwordLabelHidden.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
}
