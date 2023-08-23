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
        view.image = UIImage(named: "bgimage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    let chatButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "나와의 채팅"
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        config.image = UIImage(systemName: "message.fill")
        config.buttonSize = .small
        view.configuration = config
        return view
    }()
    
    let editButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "프로필 편집"
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        config.image = UIImage(systemName: "pencil")
        config.buttonSize = .small
        view.configuration = config
        return view
    }()
    
    let callButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "통화하기"
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .white
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        config.image = UIImage(systemName: "phone.fill")
        config.buttonSize = .small
        view.configuration = config
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backImageView)
        
        let views = [nameLabel, profileImageView, lineView, xButton, settingButton, qrButton, giftButton,  editButton, chatButton,callButton]
        
        for item in views {
            backImageView.addSubview(item)
        }
        
        setConstraints()
    }
    
    static func setImageview(image: String) -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(systemName: image)
        view.tintColor = .white
        return view
    }
    

    
    
    func setConstraints() {
        backImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.edges.equalToSuperview()
        }
        
        
        lineView.backgroundColor = .lightGray
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(editButton.snp.top).inset(-60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        xButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backImageView).inset(30)
            make.leadingMargin.equalTo(backImageView).offset(30)
            make.size.equalTo(30)
        }
        
        settingButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backImageView).inset(30)
            make.trailingMargin.equalTo(backImageView).offset(-30)
            make.size.equalTo(30)
        }
        
        qrButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backImageView).inset(30)
            make.trailing.equalTo(settingButton.snp.leading).offset(-20)
            make.size.equalTo(30)
        }
        
        giftButton.snp.makeConstraints { make in
            make.topMargin.equalTo(backImageView).inset(30)
            make.trailing.equalTo(qrButton.snp.leading).offset(-20)
            make.size.equalTo(30)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(backImageView).inset(35)
            make.size.equalTo(90)
        }
        
        chatButton.snp.makeConstraints { make in
            make.bottomMargin.equalTo(backImageView).inset(35)
            make.trailing.equalTo(editButton.snp.leading).offset(-20)
            make.size.equalTo(90)
            //make.centerX.equalTo(chatImageView)
        }
        
        callButton.snp.makeConstraints { make in
            make.leading.equalTo(editButton.snp.trailing).offset(20)
            make.bottomMargin.equalTo(backImageView).inset(35)
            make.size.equalTo(90)
        }
        
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(lineView.snp.top).offset(-120)
            make.size.equalTo(80)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.topMargin.equalTo(profileImageView.snp.bottom).offset(18)
            make.bottomMargin.equalTo(backImageView).inset(250)
            
        }
        
        
    }


    



}
