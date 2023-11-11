//
//  SearchCollectionViewCell.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    let label = {
        let view = UILabel()
        view.text = "test"
        view.backgroundColor = .white
        view.textColor = .black
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        contentView.addSubview(label)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.edges.equalTo(contentView).inset(10)
        
        }
    }
    
}
