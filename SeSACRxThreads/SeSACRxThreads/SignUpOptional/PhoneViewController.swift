//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let phone = BehaviorSubject(value: "010")
    let buttonColor = BehaviorSubject(value: UIColor.red)
    let buttonEnabled = BehaviorSubject(value: false)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        bind()
    }
    
    func bind() {
        
        buttonEnabled
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        buttonColor
            .bind(to: nextButton.rx.backgroundColor, phoneTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        buttonColor
            .map{ $0.cgColor } // cgcolor 타입으로 변경
            .bind(to: phoneTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        phone
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        phone
            .map{ $0.count > 10 } // bool값 생성
            .subscribe { value in
                let color = value ? UIColor.blue : UIColor.red
                self.buttonColor.onNext(color)
                self.buttonEnabled.onNext(value) // value 값에 따라 버튼 활성화 여부 결정
                
            }
            .disposed(by: disposeBag)
        
        
        phone
            .map{ $0.count > 10 } // bool값 생성
            .withUnretained(self) // RxSwift6~
            .subscribe { object, value in
                let color = value ? UIColor.blue : UIColor.red
                object.buttonColor.onNext(color)
                object.buttonEnabled.onNext(value) // value 값에 따라 버튼 활성화 여부 결정
                
            }
            .disposed(by: disposeBag)
        
        phone
            .map{ $0.count > 10 } // bool값 생성
            .subscribe(with: self, onNext: { owner, value in
                let color = value ? UIColor.blue : UIColor.red
                owner.buttonColor.onNext(color)
                owner.buttonEnabled.onNext(value) // value 값에 따라 버튼 활성화 여부 결정
            })
            .disposed(by: disposeBag)
        
        
        phoneTextField.rx.text.orEmpty //옵셔널 바인딩 해결
            .subscribe { value in
                let result = value.formatted(by: "###-####-####")
                self.phone.onNext(result)
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

