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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
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
