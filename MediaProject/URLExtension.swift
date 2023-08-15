//
//  URLExtension.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import Foundation

extension URL {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    
    static func makeEndPointString(_ endpoint: String, type: String) -> String {
        return baseURL + endpoint
    }
    
    static func trendEndPointString(_ type: String) -> String {
        return baseURL + "trending/\(type)/"
    }
    
    static func creditEndPointString(_ type: String) -> String {
        return baseURL + "\(type)"
    }
    
    //static func genreEndPointString(
    
   // static func getCreditURL(
    
}
