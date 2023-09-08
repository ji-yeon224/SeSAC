//
//  TrendCollectionCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/30.
//

import UIKit

class TrendCollectionCell: BaseCollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
    
    let releaseLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textColor = .lightGray
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

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func configureView() {
        contentView.addSubview(genreLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        backView.addSubview(titleLabel)
        backView.addSubview(lineView)
        backView.addSubview(detailLabel)
        backView.addSubview(chevronImage)
        
        setShadow(view: backView)
    }
    
    override func setConstraints() {
        
        releaseLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(5)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView).inset(5)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView).inset(7)
            
        }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(backView)
            make.height.equalTo(backView).multipliedBy(0.65)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(30)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(30)
            make.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(30)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.bottom.equalTo(backView).inset(10)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(30)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.bottom.equalTo(backView).inset(10)
        }
        
    }
    
}
