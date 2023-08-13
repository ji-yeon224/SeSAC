//
//  URLExtension.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation

extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    
    static func makeEndPointString(_ endpoint: String, genre: String) -> String {
        return baseURL + endpoint
    }
    
    static func trendEndPointString(_ genre: String) -> String {
        return baseURL + "trending/\(genre)/"
    }
    
    static func creditEndPointString(_ genre: String) -> String {
        return baseURL + "\(genre)/"
    }
    
   // static func getCreditURL(
    
}
