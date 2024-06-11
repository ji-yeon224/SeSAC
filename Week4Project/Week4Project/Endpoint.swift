//
//  Endpoint.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/11.
//

import Foundation

enum Endpoint {
    
    case blog
    case cafe
    case video
    
    var requestURL: String {
        switch self {
        case .blog: return URL.makeEndPoinitString("blog?query=")
        case .cafe: return URL.makeEndPoinitString("cafe?query=")
        case .video: return URL.makeEndPoinitString("vclip?query=")
        }
    }
    
}


