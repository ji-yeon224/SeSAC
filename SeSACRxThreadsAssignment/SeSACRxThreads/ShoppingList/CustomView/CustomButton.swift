//
//  CustomButton.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit

final class CustomButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = Constants.Color.cellColor
        layer.cornerRadius = 5
        setTitleColor(.black, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
