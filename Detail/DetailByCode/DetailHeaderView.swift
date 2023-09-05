//
//  DetailHeaderView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/05.
//

import UIKit
class DetailHeaderView: BaseTableViewHeaderFooterView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.backgroundColor = .black
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.alpha = 0.8
        view.backgroundColor = .yellow
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 15)
        view.text = "hello"
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(backView)
        backView.addSubview(posterImageView)
        backView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(backView).inset(16)
            make.verticalEdges.equalTo(backView).inset(22)
            
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.top.equalTo(contentView).inset(50)
            make.trailing.equalTo(contentView).inset(-22)
        }
    }
    
}
