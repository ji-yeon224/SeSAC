//
//  BaseView.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configreView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configreView() {
        
    }
    
    func setConstraints() {
        
    }
    
}
