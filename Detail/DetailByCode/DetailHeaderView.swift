//
//  DetailHeaderView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/05.
//

import UIKit
class DetailHeaderView: BaseTableViewHeaderFooterView {
    
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.alpha = 0.8
        view.layer.backgroundColor = UIColor.black.cgColor
        return view
    }()
    
    let alphaView = {
        let view = UIView()
        view.layer.backgroundColor = (UIColor.black.cgColor).copy(alpha: 0.6)
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        //view.backgroundColor = .yellow
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "hello"
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(backdropImageView)
        backdropImageView.addSubview(alphaView)
        alphaView.addSubview(posterImageView)
        alphaView.addSubview(titleLabel)
    }
    
    override func setConstraints() {
//        backView.snp.makeConstraints { make in
//            make.edges.equalTo(contentView)
//        }
//
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        alphaView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(16)
            make.verticalEdges.equalTo(contentView).inset(22)
            
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.top.equalTo(contentView).inset(50)
            make.trailing.equalTo(contentView).inset(-22)
        }
    }
    
}
