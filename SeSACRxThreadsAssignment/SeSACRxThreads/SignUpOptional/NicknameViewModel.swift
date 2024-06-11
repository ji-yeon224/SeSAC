//
//  NicknameViewModel.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/2/23.
//

import Foundation
import RxSwift

class NicknameViewModel {
    
    let buttonHidden = BehaviorSubject(value: true)
    let labelHidden = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
}
