//
//  NumberFormatter+Extension.swift
//  BoxOffice
//
//  Created by 김지연 on 11/8/23.
//

import Foundation

extension NumberFormatter {
    
    static let numFormat = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
        
    }()
    
    static func convertDecimalType(num: String) -> String {
        
        guard let num = Int(num) else { return num }
        
        return numFormat.string(for: num)!
        
    }
    
    
    
    
}
