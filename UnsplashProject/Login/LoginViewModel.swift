//
//  LoginViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("")
    var pw = Observable("")
    var isValid = Observable(false)
    
    
    func checkValidation() {
        if id.value.count >= 6 && pw.value.count >= 4 {
            isValid.value = false
        } else {
            isValid.value = true
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        
        // 서버, 닉네임, id
        UserDefaults.standard.set(id.value, forKey: "id")
        
        completion()
        
    }
    
}
