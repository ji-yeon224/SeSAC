//
//  ProfileHeaderView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/30.
//

import UIKit
class ProfileHeaderView: BaseTableViewHeaderFooterView {
    
    
    let imageButton = {
        let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
        let image = UIImage(systemName: "person.circle", withConfiguration: config)
        view.setImage(image, for: .normal)
        view.backgroundColor = .darkGray
        view.tintColor = .darkGray
        view.layer.cornerRadius = 40
        
        return view
    }()
    
    let button = {
        let view = UIButton()
        view.setTitleColor(UIColor.blue, for: .normal)
        view.backgroundColor = .clear
        view.setTitle("프로필 사진 바꾸기", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    
    
    override func configureView() {
        contentView.addSubview(imageButton)
        contentView.addSubview(button)
    }
    
    override func setConstraints() {
        imageButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.2)
            make.height.equalTo(imageButton.snp.width)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.2)
        }
    }
    
}
