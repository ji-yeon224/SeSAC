//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    
    
    let viewModel = SignInViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        emailTextField.text = "111111111"
        passwordTextField.text = "11111111"
        
        configureLayout()
        configure()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        bind()
    }
    
    
    
    func bind() {
        
        let email = emailTextField.rx.text.orEmpty
        let password = passwordTextField.rx.text.orEmpty
        
        email
            .map { $0.count >= 8 }
            .bind(with: self) { owner, value in
                owner.viewModel.emailValid.onNext(value)
            }
            .disposed(by: disposeBag)
        password
            .map { $0.count >= 6 }
            .bind(with: self) { owner, value in
                owner.viewModel.passwordValid.onNext(value)
            }
            .disposed(by: disposeBag)
        
        viewModel.emailColor
            .bind(with: self) { owner, color in
                owner.emailTextField.layer.borderColor = color.cgColor
            }
            .disposed(by: disposeBag)
        
        viewModel.passwordColor
            .bind(with: self) { owner, color in
                owner.passwordTextField.layer.borderColor = color.cgColor
            }
            .disposed(by: disposeBag)
        
        viewModel.buttonEnabled
            .bind(with: self) { owner, value in
                owner.signInButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        viewModel.buttonColor
            .bind(with: self) { owner, color in
                owner.signInButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        
        signInButton.rx.tap.subscribe(with: self) { owner, _ in
            owner.navigationController?.pushViewController(SearchViewController(), animated: true)
        }
        .disposed(by: disposeBag)
        
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
