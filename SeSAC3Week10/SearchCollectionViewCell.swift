//
//  SearchCollectionViewCell.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.text = "테스트"
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        
    }
    
}
