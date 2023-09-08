//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let label = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 15)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    
    override func configureView() {
        contentView.addSubview(label)
        contentView.addSubview(textField)
        selectionStyle = .default
    }
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).inset(30)
            //make.width.equalTo(contentView).multipliedBy(0.2)
            make.height.equalTo(contentView)
            
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(-30)
            make.width.equalTo(contentView).multipliedBy(0.7)
            make.height.equalTo(contentView)
        }
    }
    
}
