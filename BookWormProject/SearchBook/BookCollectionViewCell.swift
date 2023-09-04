//
//  BookCollectionViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    //static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    func configCell(book: BookTable) {
        titleLabel.text = book.title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        let url = URL(string: book.poster)!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
            
        }
        changeLikeButtonImage(like: book.like)
        
    }
    
    func changeLikeButtonImage(like: Bool) {
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
}
