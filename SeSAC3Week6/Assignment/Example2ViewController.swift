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
    
    let chatImageView = setImageview(image: "message.fill")
    let editImageView = setImageview(image: "pencil")
    let storyImageView = setImageview(image: "quote.closing")
    
    let chatLabel = setLabel(text: "나와의 채팅")
    let editLabel = setLabel(text: "프로필 편집")
    let storyLabel = setLabel(text: "카카오스토리")
    
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
        view.layer.cornerRadius = 50
        
        return view
    }()
    
    let lineView = UIView()
    
    let xButton = setImageview(image: "xmark.circle")
    let giftButton = setImageview(image: "gift.circle")
    let qrButton = setImageview(image: "command.circle")
    let settingButton = setImageview(image: "gearshape.circle")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backImageView)
        
        let views = [chatLabel, chatImageView, editLabel, editImageView, storyLabel, storyImageView, nameLabel, profileImageView, lineView, xButton, settingButton, qrButton, giftButton]
        
        for item in views {
            backImageView.addSubview(item)
        }
        
  
        setImageViewConstraints()
        setLabelConstraints()
        setConstraints()
    }
    
    static func setImageview(image: String) -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(systemName: image)
        view.tintColor = .white
        return view
    }
    
    static func setLabel(text: String) -> UILabel {
        let view = UILabel()
        view.text = text
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }
    
    
    
    func setConstraints() {
        lineView.backgroundColor = .lightGray
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(backImageView).inset(200)
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
    }
    
    func setImageViewConstraints() {
        
        backImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        editImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(backImageView).inset(70)
            make.size.equalTo(30)
        }
        
        
        chatImageView.snp.makeConstraints { make in
            //make.leadingMargin.equalTo(60)
            make.trailing.equalTo(editImageView.snp.leading).offset(-70)
            make.bottomMargin.equalTo(backImageView).inset(100)
            make.size.equalTo(30)
            
        }
        
        storyImageView.snp.makeConstraints { make in
            //make.trailingMargin.equalTo(-60)
            make.leading.equalTo(editImageView.snp.trailing).offset(70)
            make.bottomMargin.equalTo(backImageView).inset(70)
            make.size.equalTo(30)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(backImageView).inset(290)
            make.size.equalTo(80)
            
        }
        
        
        
        
    }
    
    func setLabelConstraints() {
        
        editLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(backImageView).inset(50)
            make.top.equalTo(editImageView.snp.bottom).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.centerX.equalTo(editImageView)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(backImageView).inset(50)
            make.top.equalTo(chatImageView.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerX.equalTo(chatImageView)
        }
        
        storyLabel.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-40)
            make.bottomMargin.equalTo(backImageView).inset(50)
            make.top.equalTo(storyImageView.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerX.equalTo(storyImageView)
        }
        
        
        nameLabel.text = "지연"
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backImageView)
            make.bottomMargin.equalTo(backImageView).inset(250)
            
        }
        
    }
    



}
