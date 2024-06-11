//
//  BaseViewModel.swift
//  SeSACRxSummery
//
//  Created by 김지연 on 11/8/23.
//

import Foundation


protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    
}





