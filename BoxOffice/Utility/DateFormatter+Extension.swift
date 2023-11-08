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
        format.dateFormat = "yyyyMMdd"
        return format
        
    }()
    
    static let formatLine = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        format.dateFormat = "yyyy-MM-dd"
        return format
        
    }()
    
    static func convertDateByLine(date: Date) -> String {
        return formatLine.string(from: date)
    }
    
    static func convertDate(date: Date) -> String {
        return formatDate.string(from: date)
    }
    
    static func yesterdayDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
    }
}
