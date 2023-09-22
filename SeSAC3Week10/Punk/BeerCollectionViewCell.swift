//
//  BeerCollectionViewCell.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/22.
//

import UIKit
import SnapKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfigure() {
        //contentView.addSubview(imageView)
        contentView.addSubview(label)
        
    }
    
    private func setConstraints() {
//        imageView.backgroundColor = .lightGray
//        imageView.snp.makeConstraints { make in
//            make.height.equalTo(contentView)
//            make.leading.equalTo(contentView)
//            make.width.equalTo(contentView).multipliedBy(0.3)
//
//        }
        
        label.text = "text"
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.height.equalTo(contentView)
            make.trailing.equalTo(contentView)
        }
    }
    
    
}
