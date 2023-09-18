//
//  PhotoViewModel.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    
    func fetchPhoto(text: String) {
        
        APIService.shared.searchPhoto(query: text) { photo in
            
            DispatchQueue.main.async {
                guard let photo  = photo else {
                    return
                }
                self.list.value = photo
            }
            
            
            
        }
    }
    
    var rowCount: Int {
        return list.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
    
    
}
