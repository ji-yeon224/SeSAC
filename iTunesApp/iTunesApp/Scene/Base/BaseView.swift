//
//  BaseView.swift
//  iTunesApp
//
//  Created by 김지연 on 11/12/23.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        backgroundColor = Constants.Color.background
        
    }
    
    func setConstraints() {
        
    }
    
    
}
