//
//  DateFormatter+Extension.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import Foundation

extension DateFormatter {
    
    static let formatDate = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        format.dateFormat = "yyyy-MM-dd"
        return format
        
    }()
    
    
    static func convertDate(date: Date) -> String {
        return formatDate.string(from: date)
    }
}
