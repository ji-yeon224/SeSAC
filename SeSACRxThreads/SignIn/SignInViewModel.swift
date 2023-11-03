//
//  SignInViewModel.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import Foundation
import RxSwift

class SignInViewModel {
    
    let buttonEnabled = BehaviorSubject(value: true)
    var validation = Observable.of(false)
    let disposeBag = DisposeBag()
    
    let buttonColor = BehaviorSubject(value: Constants.Color.lightGray)
    let emailColor = BehaviorSubject(value: Constants.Color.lightGray)
    let passwordColor = BehaviorSubject(value: Constants.Color.lightGray)
    
    let emailValid = BehaviorSubject(value: false)
    let passwordValid = BehaviorSubject(value: false)
    
    
    init() {
        
        emailValid
            .bind(with: self) { owner, value in
                owner.emailColor.onNext(value ? Constants.Color.blue : Constants.Color.red)
            }
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(with: self) { owner, value in
                owner.passwordColor.onNext(value ? Constants.Color.blue : Constants.Color.red)
            }
            .disposed(by: disposeBag)
        
        validation = Observable.combineLatest(emailValid, passwordValid) {
            return $0 && $1
        }
        
        validation
            .bind(with: self) { owner, value in
                owner.buttonEnabled.onNext(value)
                owner.buttonColor.onNext(value ? Constants.Color.blue : Constants.Color.lightGray)
            }
            .disposed(by: disposeBag)
    }
}
