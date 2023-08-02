//
//  PosterCollectionViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/08/02.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCollectionViewCell"
    
    @IBOutlet var posterImageView: UIImageView!

    func configurePosterImage(movieTitle: String) {
        posterImageView.image = UIImage(named: movieTitle)
    }
    
    
    
    

}
