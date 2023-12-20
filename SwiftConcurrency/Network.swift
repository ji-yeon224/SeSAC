//
//  Network.swift
//  SwiftConcurrency
//
//  Created by 김지연 on 12/19/23.
//

import UIKit

enum JackError: Error {
    case invalidResponse
    case unknown
    case invalidImage
    
}

class Network {
    
    static let shared = Network()
    
    private init() { }
    
    func fetchThumbnail(completion: @escaping (UIImage) -> Void) {
        let url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/7M2pc9OboapgtoBbkU49Aim7O5B.jpg"
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                    
                }
            }
        }
        
        
    }
    
    
    func fetchThumbnailURLSession(completion: @escaping (Result<UIImage, JackError>) -> Void) {
        
        let url = URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/7M2pc9OboapgtoBbkU49Aim7O5B.jpg")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                completion(.failure(.unknown))
                return
            }
            
            guard error == nil else {
                completion(.failure(.unknown))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidImage))
                return
            }
            
            completion(.success(image))
            
        }.resume()
        
    }
    
    // 비동기로 동작
    func fetchThumbnailAsyncAwait(value: String) async throws -> UIImage {
        print(#function, "3-1", Thread.isMainThread)
        let url = URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/\(value).jpg")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        // await: 비동기를 동기처럼 작업할 것이니까, 응답 올 때 까지 기다려라
        let (data, response) = try await URLSession.shared.data(for: request)
        print(#function, "3-2", Thread.isMainThread)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw JackError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw JackError.invalidImage
        }
//        print(response.url)
        return image
        
    }
    @MainActor
    func fetchThumbnailAsyncLet() async throws -> [UIImage] {
        print(#function, "2-1", Thread.isMainThread)
        async let image1 = try await Network.shared.fetchThumbnailAsyncAwait(value: "aZuBfbR0PnCb2up7lqHDsgJlLjs")
        async let image2 = try await Network.shared.fetchThumbnailAsyncAwait(value: "lMWTlGr9jVUC18T515hPRKym5QQ")
        async let image3 = try await Network.shared.fetchThumbnailAsyncAwait(value: "7M2pc9OboapgtoBbkU49Aim7O5B")
        print(#function, "2-2", Thread.isMainThread)
        return try await [image1, image2, image3]
        
    }
    
    func fetchThumbnailTaskGroup() async throws -> [UIImage] {
        let poster = ["aZuBfbR0PnCb2up7lqHDsgJlLjs", "lMWTlGr9jVUC18T515hPRKym5QQ", "7M2pc9OboapgtoBbkU49Aim7O5B"]
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            for item in poster {
                group.addTask { // 네트워크 통신이 몇 번 일어날 지 모르니까 그룹으로 묶기 위해 addTask
                    try await self.fetchThumbnailAsyncAwait(value: item)
                }
            }
            
            // group에 addTask를 하기 때문에 응답 값 또한 group이 가지고 있다.
            var resultImages: [UIImage] = []
            
            for try await item in group {
                resultImages.append(item)
            }
            
            return resultImages
            
        }
        
    }
    
}
