//
//  InvalidLabel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import UIKit

class InvalidLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        textColor = .white
        font = .systemFont(ofSize: 15)
        textAlignment = .left
        textColor = .red
        isHidden = true
    }
    
}
