//
//  LoginUpdateViewController.swift
//  SeSACTest
//
//  Created by 김지연 on 12/11/23.
//

import UIKit

struct User {
    let email: String
    let password: String
    let check: String
}

struct Validator {
    func isValidEmail(email: String) -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
}

class LoginUpdateViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var checkTextField: UITextField!
    
    let validator = Validator()
    var user = User(email: "", password: "", check: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func clicked(_ sender: Any) {
        
        user = User(email: emailTextField.text!, password: passwordTextField.text!, check: checkTextField.text!)
        
        if validator.isValidEmail(email: user.email)
            && validator.isValidPassword(password: user.password)
            && validator.isEqualPassword(password: user.password, check: user.check) {
            print("성공")
        } else {
            print("실패")
        }
        
    }
    
    

}
