//
//  URLExtension.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation

extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
    

}
