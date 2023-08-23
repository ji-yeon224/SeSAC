//
//  Example2ViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit

class Example2ViewController: UIViewController {
    
    let backImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backgroundImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let backOpacityView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        return view
    }()
    
    let bottomView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.text = "jiyeon"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 21)
        return view
    }()
    
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "damgom")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    let lineView = UIView()
    
    let xButton = setImageview(image: "xmark")
    let giftButton = setImageview(image: "gift.circle")
    let qrButton = setImageview(image: "command.circle")
    let settingButton = setImageview(image: "gearshape.circle")
    
    let chatButton = setButton(title: "나와의 채팅", image: "message.fill")
    let editButton = setButton(title: "프로필 편집", image: "pencil")
    let callButton = setButton(title: "통화하기", image: "phone.fill")
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chatButton, editButton, callButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        stackView.alignment = .fill
        stackView.backgroundColor = .yellow
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(backImageView)
        backImageView.addSubview(backOpacityView)
        let views = [bottomView, nameLabel, profileImageView, lineView, xButton, settingButton, qrButton, giftButton,  editButton, chatButton,callButton]
        
        backOpacityView.addSubview(stackView)
        for item in views {
            backImageView.addSubview(item)
        }
        setViewConstraints()
        setConstraints()
    }
    
    static func setImageview(image: String) -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(systemName: image)
        view.tintColor = .white
        return view
    }
    
    static func setButton(title: String, image: String) -> UIButton {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = title
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        config.image = UIImage(systemName: image)
        config.buttonSize = .small
        view.configuration = config
        return view
    }
    
    func setViewConstraints() {
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backOpacityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(backOpacityView)
            make.height.equalTo(90)
            make.bottomMargin.equalTo(backOpacityView).inset(30)
            
        }
        
        lineView.backgroundColor = .lightGray
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(backOpacityView)
            make.bottomMargin.equalTo(stackView.snp.top).inset(-60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
      
    }
    

    
    
    func setConstraints() {
        
        
        
        
        
        xButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backOpacityView).inset(30)
            make.leadingMargin.equalTo(backOpacityView).offset(30)
            make.size.equalTo(30)
        }
        
        settingButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backOpacityView).inset(30)
            make.trailingMargin.equalTo(backOpacityView).offset(-30)
            make.size.equalTo(30)
        }
        
        qrButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backOpacityView).inset(30)
            make.trailing.equalTo(settingButton.snp.leading).offset(-20)
            make.size.equalTo(30)
        }
        
        giftButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backOpacityView).inset(30)
            make.trailing.equalTo(qrButton.snp.leading).offset(-20)
            make.size.equalTo(30)
        }
        
        chatButton.snp.makeConstraints { make in
            make.bottomMargin.equalTo(stackView)
            make.trailing.equalTo(editButton.snp.leading).offset(-20)
            make.size.equalTo(90)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalTo(stackView)
            make.bottomMargin.equalTo(stackView)
            make.size.equalTo(90)
        }

        

        callButton.snp.makeConstraints { make in
            make.leading.equalTo(editButton.snp.trailing).offset(20)
            make.bottomMargin.equalTo(stackView)
            make.size.equalTo(90)
        }
        
        
        
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backOpacityView)
            make.bottomMargin.equalTo(lineView.snp.top).offset(-110)
            make.size.equalTo(80)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backOpacityView)
            make.topMargin.equalTo(profileImageView.snp.bottom).offset(18)
            make.bottomMargin.equalTo(backOpacityView).inset(250)
            make.height.equalTo(25)
            
        }
        //stackView.backgroundColor = .yellow
        
        
        
        
        
    }


    



}
