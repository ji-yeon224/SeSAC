//
//  SignUpViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    let netflixLabel = {
        let view = UILabel()
        view.text = "NETFLIX"
        view.font = .systemFont(ofSize: 40, weight: .heavy)
        view.textAlignment = .center
        view.textColor = .red
        return view
    }()
    
    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nickNameTextField, locationTextField, recCodeTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let emailTextField = textField(title: "이메일 주소 또는 전화번호")
    let passwordTextField = textField(title: "비밀번호")
    let nickNameTextField = textField(title: "닉네임")
    let locationTextField = textField(title: "위치")
    let recCodeTextField = textField(title: "추천 코드 입력")
    
    static func textField(title: String) -> UITextField {
        let view = TextFieldStyle()
        view.text = title
        return view
    }
    
    let signUpButton = {
        let view = UIButton()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        
        var config = UIButton.Configuration.filled()
        config.title = "회원가입"
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.titleAlignment = .center
        view.configuration = config
        
        return view
    }()
    
    
    lazy var infoStackView = {
        let infoStackView = UIStackView(arrangedSubviews: [addInfoLabel, infoSwitch])
        
        infoStackView.axis = .horizontal
        infoStackView.distribution = .fill
        infoStackView.alignment = .fill
        return infoStackView
    }()
    
    let addInfoLabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .white
        
        return view
    }()
    
    let infoSwitch = {
        let view = UISwitch()
        view.onTintColor = .red
        view.isOn = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setConstraints()
    }
    
    func setConstraints() {
        
        view.addSubview(netflixLabel)
        netflixLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
        }
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        recCodeTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(18)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        view.addSubview(infoStackView)
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(18)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(30)
        }

        addInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoStackView.snp.leading)
        }

        
        infoSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(infoStackView.snp.trailing)
        }
        
        
        
        
    }
    
  
    

}
