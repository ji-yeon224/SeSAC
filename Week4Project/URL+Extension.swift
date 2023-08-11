//
//  URL+Extension.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/11.
//

import Foundation

extension URL {
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPoinitString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
    
}
