//
//  URLSessionAPI.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/02.
//

import Foundation

class URLSessionAPI {
    
    private init() { }
    
    static let shared = URLSessionAPI()
    
    func callTrendRequestURLSession(endPoint: Endpoint, parameter: String, completionHandler: @escaping (Contents?) -> Void) {
        guard let url = URL(string: endPoint.requestURL(type: parameter) + "?api_key=\(APIKey.tmdbKey)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error {
                    print(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Contents.self, from: data)
                    completionHandler(result)
                } catch {
                    completionHandler(nil)
                }
            }
           
        }.resume()
        
        
        
    }
    
    
}
