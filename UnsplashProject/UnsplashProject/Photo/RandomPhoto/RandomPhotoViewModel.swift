//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/19.
//

import Foundation

class RandomPhotoViewModel {
    
    var photo = Observable(Random(id: "", urls: nil, likes: 0))
    var photoImageData = Observable<Data?>(Data())
    
    
    func fetchRandomPhoto() {
        APIService.shared.getRandomPhoto { result in
            
            DispatchQueue.main.async {
                self.photo.value = result
            }
            
        }
    }
    
    func getImageData() {
        APIService.shared.getRandomPhoto { result in
            DispatchQueue.global().async {
                guard let imageString = result.urls?.thumb else {
                    return
                }
                guard
                    let url = URL(string: imageString)
                else { return }
                
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.photoImageData.value = data
                }
                
            }
        }
    }
    
   
    
}
