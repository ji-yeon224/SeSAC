//
//  SeSACButton.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/21.
//

import UIKit

@IBDesignable
class SeSACButton: UIButton {
    
    @IBInspectable //스토리보드에서 속성을 적용하고 싶을 때
    var jack: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
}
