//
//  TextFieldStyle.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit

class TextFieldStyle: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        layer.cornerRadius = 5
        backgroundColor = .darkGray
        textColor = .white
        font = .systemFont(ofSize: 15)
        textAlignment = .center
    }
    
    
}

