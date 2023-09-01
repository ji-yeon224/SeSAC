//
//  APIService.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() { }
    
    
    
    static let shared = APIService() //인스턴스 생성 방지
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        print(query)
        guard let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=\(APIKey.unsplashKey)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error {
                    print(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil) //completionHandler에서 nil값이 넘어오면 문제가 생겼다 판단 후 에러핸들링 가능
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                    
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                }
            }
           
            
            
            
        }.resume()
    }
    
}

struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
