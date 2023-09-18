//
//  SignUpView.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let netflixLabel = {
        let view = UILabel()
        view.text = "NETFLIX"
        view.font = .systemFont(ofSize: 40, weight: .heavy)
        view.textAlignment = .center
        view.textColor = .red
        return view
    }()
    
    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, emailInvalid, passwordTextField, passwordInvalid, nickNameTextField, nicknameInvalid, locationTextField, locationInvalid, recommendTextField, recommendInvalid])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 13
        stackView.alignment = .fill
        
        return stackView
    }()
    
    var emailTextField = textField(title: "이메일 주소 또는 전화번호")
    var passwordTextField = textField(title: "비밀번호")
    var nickNameTextField = textField(title: "닉네임")
    var locationTextField = textField(title: "위치")
    var recommendTextField = textField(title: "추천 코드 입력")
    
    var emailInvalid = InvalidLabel()
    var passwordInvalid = InvalidLabel()
    var nicknameInvalid = InvalidLabel()
    var locationInvalid = InvalidLabel()
    var recommendInvalid = InvalidLabel()
   
//    let invalidLabel = {
//        let view = UILabel()
//        view.textColor = .red
//        view.font = .systemFont(ofSize: 15)
//        view.textAlignment = .left
//        view.text = "invalid"
//        return view
//    }()
    
    static func textField(title: String) -> UITextField {
        let view = TextField()
        view.placeholder = title
        view.attributedPlaceholder = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
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
        
        view.isEnabled = false
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
    
    
    
    func configure() {
        addSubview(netflixLabel)
        addSubview(stackView)
        addSubview(signUpButton)
        //addSubview(invalidLabel)
        addSubview(infoStackView)
        
    }
    
    func setConstraints() {
        
        netflixLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
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
        
        recommendTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(18)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
//        invalidLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(signUpButton.snp.bottom).offset(10)
//            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
//            make.height.equalTo(20)
//
//        }
        
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(18)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
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
