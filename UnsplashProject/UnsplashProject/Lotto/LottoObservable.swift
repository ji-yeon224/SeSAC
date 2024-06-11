//
//  LottoObservable.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/13.
//

import Foundation


class LottoObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            //print(value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(handler: @escaping (T) -> Void) {
        listener = handler
    }
    
}
