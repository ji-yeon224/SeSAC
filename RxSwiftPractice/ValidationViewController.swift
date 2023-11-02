//
//  ValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 김지연 on 11/1/23.
//

import UIKit
import RxSwift

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class ValidationViewController: UIViewController {
    
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var usernameValidLabel: UILabel!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!
    
    @IBOutlet var checkButton: UIButton!
    
    let usernameLabelHidden = BehaviorSubject(value: false)
    let passwordLabelHidden = BehaviorSubject(value: false)
    let passwordTextFieldEnabled = BehaviorSubject(value: true)
    let userNameValid = BehaviorSubject(value: false)
    let passwordValid = BehaviorSubject(value: false)
    let totalValid = BehaviorSubject(value: false)
    let checkButtonEnabled = BehaviorSubject(value: true)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        bind()
//        example()
    }
    
    func bind() {
        
        usernameLabelHidden
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordLabelHidden
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        checkButtonEnabled
            .bind(to: checkButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        passwordTextFieldEnabled
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameTextfield.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.userNameValid.onNext(value)
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.passwordValid.onNext(value)
            }
            .disposed(by: disposeBag)
        
        let totalValidation = Observable.combineLatest(userNameValid, passwordValid) {
            return $0 && $1
        }
        
        userNameValid
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.usernameLabelHidden.onNext(value)
                owner.passwordTextFieldEnabled.onNext(value)
            }
            .disposed(by: disposeBag)

        passwordValid
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.passwordLabelHidden.onNext(value)
            }
            .disposed(by: disposeBag)
        
        totalValid
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, value in
                owner.checkButtonEnabled.onNext(value)
            }
            .disposed(by: disposeBag)
        
        totalValidation
            .bind(to: checkButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        checkButton.rx.tap
            .bind(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func example() {
        let usernameValid = usernameTextfield.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let totalValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        totalValid
            .bind(to: checkButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        checkButton.rx.tap
            .bind(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}
