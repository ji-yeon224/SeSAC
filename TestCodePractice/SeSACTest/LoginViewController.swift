//
//  LoginViewController.swift
//  SeSACTest
//
//  Created by 김지연 on 12/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var checkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let koko: 주방장레시피 = 코코종()
        let food: 중국집 = 코종반점(주인: koko)
        let hue = 휴님(중국집: food)
        
        
    }
    
    
    @IBAction func clicked(_ sender: Any) {
        if isValidEmail() && isValidPassword() && isEqualPassword() {
            print("성공")
        } else {
            print("실패")
        }
        
    }
    
    func isValidEmail() -> Bool {
        guard let check = emailTextField.text else {
            return false
        }
        return check.contains("@") && check.count >= 6
    }
    
    func isValidPassword() -> Bool {
        guard let check = passwordTextField.text else {
            return false
        }
        
        return check.count >= 6 && check.count < 10
    }
    
    func isEqualPassword() -> Bool {
        guard let password = passwordTextField.text, let check = checkTextField.text else {
            return false
        }
        return password == check
    }
    

}
