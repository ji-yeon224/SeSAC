//
//  String+Extension.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/11.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
    
    //let value = NSLocalizedString("nickname_result", comment: "")
    //resultLabel.text = String(format: value, "고래밥", "다마고치", "칙촉")
}
