//
//  ValidateViewController.swift
//  SeSACRxSummery
//
//  Created by 김지연 on 11/7/23.
//

import UIKit
import RxSwift
import RxCocoa

class ValidateViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var validationLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    let viewModel = ValidateViewModel()
    
    //let validText = BehaviorRelay(value: "닉네임은 8자 이상")
    let labelHidden = BehaviorRelay(value: false)
    let buttonEnable = BehaviorRelay(value: false)
    let buttonColor = BehaviorRelay(value: UIColor.lightGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .white
    }
    
    private func bind() {
        
        
        
        viewModel.validText
            .asDriver()
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = nameTextField.rx.text.orEmpty
            .map { $0.count >= 8 }
        
        validation
            .bind(to: nextButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validation
            .bind(with: self) { owner, value in
            let color: UIColor = value ? .systemPink : .lightGray
            owner.nextButton.backgroundColor = color
        }
            .disposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .bind(with: self) { owner, value in
//                print("tap")
//            }
//            .disposed(by: disposeBag)
//        
//        labelHidden
//            .asDriver()
//            .drive(validationLabel.rx.isHidden)
//            .disposed(by: disposeBag)
//        
//        buttonEnable
//            .asDriver()
//            .drive(nextButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//        
//        buttonColor
//            .asDriver()
//            .drive(nextButton.rx.backgroundColor)
//            .disposed(by: disposeBag)
        
        // textfield 8글자 이상이면, label hidden, button enable
//        nameTextField.rx.text.orEmpty
//            .map{ $0.count >= 8 }
//            .bind(with: self) { owner, value in
//                owner.labelHidden.accept(value)
//                owner.buttonEnable.accept(value)
//                owner.buttonColor.accept(value ? UIColor.systemPink : UIColor.lightGray)
//            }
//            .disposed(by: disposeBag)
        
    }
    
    
}
