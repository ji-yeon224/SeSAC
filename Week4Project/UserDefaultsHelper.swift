//
//  UserDefaultsHelper.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/11.
//

import Foundation




class UserDefaultsHelper { //PropertyWrapper
    
    static let standard = UserDefaultsHelper()
    
    private init() { } //접근 제어자
    
    let userDefaults = UserDefaults.standard //자주 사용하는 키워드 상수에 저장
    
    enum Key: String { //클래스 내부에 선언하여 컴파일 시간은 줄일 수 있음 -> 컴파일 최적화
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            return userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
        
    
}
