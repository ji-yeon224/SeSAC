//
//  BookCollectionViewCell.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    
    
    func configCell(movie: Movie) {
        
        titleLabel.text = movie.title
        titleLabel.textColor = .white
        
        rateLabel.text = "\(movie.rate)"
        rateLabel.textColor = .white
        posterImageView.image = UIImage(named: movie.title)
        
        
        
    }
    
    
}
