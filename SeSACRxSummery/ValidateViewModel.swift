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
    
    let validText = BehaviorRelay(value: "닉네임은 8자 이상")
    
    struct Input {
        
        let text: ControlProperty<String?> //nameTextField.tx.text
        let tap: ControlEvent<Void> // nextButton.rx.tap
        
        
    }
    
    struct Output {
        
        let tap: ControlEvent<Void>
        let text: Driver<String>
        let validation: Observable<Bool>
        
    }
    
}

