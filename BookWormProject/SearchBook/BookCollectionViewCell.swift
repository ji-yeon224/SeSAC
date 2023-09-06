//
//  BookCollectionViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    //@IBOutlet var likeButton: UIButton!
    
    func configCell(book: BookTable) {
        
        
        guard let url = URL(string: book.posterURL) else {
            posterImageView.image = UIImage(systemName: "book.closed.fill")!
            posterImageView.tintColor = .lightGray
            return
        }
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
            
        }
        
        
    }

    
    
}
