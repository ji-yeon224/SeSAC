//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation

class RandomPhotoViewModel {
    
    var photo = Observable(Random(id: "", urls: nil, likes: 0))
    
    func fetchRandomPhoto() {
        APIService.shared.getRandomPhoto { result in
            //print(result)
            
            DispatchQueue.main.async {
                self.photo.value = result
            }
            
        }
    }
    
    func getRandomImage() {
        
    }
    
}
