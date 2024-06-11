//
//  BasicLabel.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import UIKit

final class BasicLabel: UILabel {
    
    init(fontSize: CGFloat, lines: Int) {
        super.init(frame: .zero)
        textColor = Constants.Color.basicFont
        font = .systemFont(ofSize: fontSize)
        numberOfLines = lines
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
