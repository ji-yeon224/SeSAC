//
//  CastCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

class CastCell: BaseTableViewCell {
    
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.tintColor = .darkGray
        view.contentMode = .scaleToFill
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "name"
        return view
    }()
    
    let characterLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.text = "character"
        view.numberOfLines = 1
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView).inset(10)
            make.width.equalTo(contentView).multipliedBy(0.2)
            make.height.equalTo(profileImageView.snp.width).multipliedBy(4/3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.top.equalTo(contentView).offset(12)
            
            make.trailing.equalTo(contentView).offset(12)
            
            
        }
        
        characterLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            
            make.bottom.equalTo(contentView).offset(-10)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
    
}
