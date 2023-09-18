//
//  SignUpViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        self.view = mainView
        view.backgroundColor = .black
        configureView()
        bindData()
    }
    
    func configureView() {
        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        mainView.nickNameTextField.addTarget(self, action: #selector(nickNameTextFieldChanged), for: .editingChanged)
        mainView.locationTextField.addTarget(self, action: #selector(locationTextFieldChanged), for: .editingChanged)
        mainView.recommendTextField.addTarget(self, action: #selector(recommendTextFieldChanged), for: .editingChanged)
        
        
    }
    
    func bindData() {
        
        viewModel.email.bind { value in
            self.mainView.emailTextField.text = value
        }
        viewModel.password.bind { value in
            self.mainView.passwordTextField.text = value
        }
        viewModel.nickname.bind { value in
            self.mainView.nickNameTextField.text = value
        }
        viewModel.location.bind { value in
            self.mainView.locationTextField.text = value
        }
        viewModel.recommend.bind { value in
            self.mainView.recommendTextField.text = value
        }
        viewModel.validCheck.bind { value in
            self.mainView.signUpButton.isEnabled = value
        }
        
    }
    
    
    
    @objc func emailTextFieldChanged() {
        viewModel.email.value = mainView.emailTextField.text
        if viewModel.checkEmail() {
            mainView.emailInvalid.isHidden = true
        } else {
            mainView.emailInvalid.isHidden = false
            mainView.emailInvalid.text = viewModel.emailInvalid.value
        }
        viewModel.checkEnabled()
        
    }
    
    @objc func passwordTextFieldChanged() {
        viewModel.password.value = mainView.passwordTextField.text
        if viewModel.checkPassword() {
            mainView.passwordInvalid.isHidden = true
        } else {
            mainView.passwordInvalid.isHidden = false
            mainView.passwordInvalid.text = viewModel.passwordInvalid.value
        }
        viewModel.checkEnabled()
    }
    
    @objc func nickNameTextFieldChanged() {
        viewModel.nickname.value = mainView.nickNameTextField.text
        if viewModel.nickNameCheck() {
            mainView.nicknameInvalid.isHidden = true
        } else {
            mainView.nicknameInvalid.isHidden = false
            mainView.nicknameInvalid.text = viewModel.nicknameInvalid.value
        }
        viewModel.checkEnabled()
    }
    
    @objc func locationTextFieldChanged() {
        viewModel.location.value = mainView.locationTextField.text
        if viewModel.locationCheck() {
            mainView.locationInvalid.isHidden = true
        } else {
            mainView.locationInvalid.isHidden = false
            mainView.locationInvalid.text = viewModel.locationInvalid.value
        }
        viewModel.checkEnabled()
    }
    
    @objc func recommendTextFieldChanged() {
        viewModel.recommend.value = mainView.recommendTextField.text
        if viewModel.recommendCheck() {
            mainView.recommendInvalid.isHidden = true
        } else {
            mainView.recommendInvalid.isHidden = false
            mainView.recommendInvalid.text = viewModel.recommendInvalid.value
        }
        viewModel.checkEnabled()
    }
    
    
    
    
    
}
