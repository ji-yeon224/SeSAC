//
//  RankCollectionViewCell.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import UIKit
import SnapKit

final class RankCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "RankCollectionViewCell"
    
    var rankLabel = BasicLabel(fontSize: 15, lines: 1)
    
    var titleLabel = BasicLabel(fontSize: 15, lines: 2)
    
    var totalCount = BasicLabel(fontSize: 13, lines: 1)
    var dailyCount = BasicLabel(fontSize: 13, lines: 1)
    
    private let stackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .trailing
        view.axis = .vertical
        view.spacing = 2
        return view
    }()
    
    override func configure() {
        super.configure()
        contentView.layer.cornerRadius = 10
        contentView.addSubview(rankLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(dailyCount)
        stackView.addArrangedSubview(totalCount)
        
    }
    
    override func setConstraints() {
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.size.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(rankLabel.snp.trailing).offset(10)
            //make.trailing.equalTo(contentView).offset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-10)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(contentView)
        }
        
        
        
    }
    
}
