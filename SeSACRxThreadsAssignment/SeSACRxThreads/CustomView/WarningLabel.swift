//
//  WarningLabel.swift
//  SeSACRxThreads
//
//  Created by 김지연 on 11/1/23.
//

import UIKit

class WarningLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        textColor = .red
        font = .systemFont(ofSize: 13)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
