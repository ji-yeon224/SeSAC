//
//  ValidateViewModel.swift
//  SeSACRxSummery
//
//  Created by 김지연 on 11/7/23.
//

import Foundation
import RxSwift
import RxCocoa

class ValidateViewModel {
    
    
    
    struct Input {
        
        let text: ControlProperty<String?> //nameTextField.tx.text
        let tap: ControlEvent<Void> // nextButton.rx.tap
        
        
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let text: Observable<String>
        let validation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let validation = input.text.orEmpty.map{ $0.count >= 8 }
        
        let validText = Observable.of("닉네임은 8자 이상")
        //BehaviorRelay(value: "닉네임은 8자 이상").asDriver()
        
        return Output(
            tap: input.tap,
            text: validText,
            validation: validation)
        
    }
    
}

