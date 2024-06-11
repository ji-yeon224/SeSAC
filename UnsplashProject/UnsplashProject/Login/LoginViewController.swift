//
//  LoginViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        viewModel.id.bind { text in
            print("ID Bind \(text)")
            self.idTextField.text = text
        }
        
        viewModel.pw.bind { text in
            self.pwTextField.text = text
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .lightGray
        }
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        
    }
    
    @objc func pwTextFieldChanged() {
        viewModel.pw.value = pwTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func idTextFieldChanged() {
        viewModel.id.value = idTextField.text!
        viewModel.checkValidation()
    }
    
    @objc func loginButtonClicked() {
        
        viewModel.signIn {
            // 로그인 관련 확인 저장 완료 후 실행
            print("로그인 성공 -> 얼럿 ")
        }
        
    }
    
}
