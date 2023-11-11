//
//  SearchTableViewCell.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import SnapKit

final class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    let appIconImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let appNameLabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.textColor = .black
        view.font = .systemFont(ofSize: 15)
        view.numberOfLines = 2
        view.textAlignment = .left
        return view
    }()
    
    
    
    let installButton = {
        let view = UIButton()
        view.layer.cornerRadius = 10
        view.setTitleColor(Constants.Color.buttonTint, for: .normal)
        view.backgroundColor = Constants.Color.buttonBackground
        
        view.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appIconImage.image = nil
        appNameLabel.text = nil
        installButton.titleLabel?.text = nil
    }
    
    private func config() {
        contentView.addSubview(appIconImage)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(installButton)
    }
    
    private func setConstraints() {
        
        appIconImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.height.equalTo(contentView).multipliedBy(0.8)
            make.width.equalTo(appIconImage.snp.height)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(appIconImage.snp.trailing).offset(18)
            make.trailing.equalTo(installButton.snp.leading).offset(-10)
            make.height.equalTo(contentView).multipliedBy(0.8)
        }
        
        installButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(contentView).multipliedBy(0.3)
            make.width.equalTo(appIconImage.snp.width)
        }
    }
    
    
}
