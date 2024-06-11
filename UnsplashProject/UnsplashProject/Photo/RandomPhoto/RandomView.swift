//
//  RandomView.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit

class RandomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let randomButton = {
        let view = UIButton()
        view.setTitle("GET RANDOM PHOTO", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .darkGray
        return view
    }()
    
    private func configure() {
        addSubview(randomButton)
        addSubview(imageView)
        
        
    }
    
    private func setConstraints() {
        
        randomButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.6)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        
    }
}
