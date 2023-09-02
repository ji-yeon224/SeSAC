//
//  DramaCollectionViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/02.
//

import UIKit

class DramaCollectionViewCell: BaseCollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.contentMode = .scaleToFill
        
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.numberOfLines = 0
        return view
    }()
    
    let genreLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.numberOfLines = 0
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let detailLabel = {
        let view = UILabel()
        view.text = "자세히 보기"
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let chevronImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .darkGray
        return view
    }()
    
    func setShadow(view: UIView) {
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
    }
    
    override func configureView() {
        contentView.addSubview(backView)
        contentView.addSubview(genreLabel)
        backView.addSubview(imageView)
        backView.addSubview(titleLabel)
        backView.addSubview(lineView)
        backView.addSubview(detailLabel)
        backView.addSubview(chevronImage)
        setShadow(view: backView)
        
    }
    
    override func setConstraints() {
        
        genreLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(5)
            make.height.equalTo(contentView).multipliedBy(0.35)
        }
        backView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView).inset(5)
            //make.height.equalTo(contentView).multipliedBy(0.7)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(backView).inset(14)
            make.leading.equalTo(backView).inset(14)
            make.width.equalTo(backView).multipliedBy(0.35)
            make.height.equalTo(backView).multipliedBy(0.7)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(backView).inset(10)
            make.height.equalTo(1)
        }
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(backView).inset(30)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.bottom.equalTo(backView).inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(backView).inset(18)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        chevronImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.bottom.equalTo(backView).inset(10)
        }
        
    }
    
    
}
