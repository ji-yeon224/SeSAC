//
//  TrendCollectionViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var releaseLabel: UILabel!
    
    @IBOutlet var genreLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.backgroundColor = .black
        posterImage.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        configure()
    }
    
    func configure() {
        backView.backgroundColor = .white
        setShadow()
    }
    func setShadow() {
        
        
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 5
        backView.layer.shadowOpacity = 0.5
        backView.clipsToBounds = false
        backView.layer.masksToBounds = false
        
        
    }
    
    
    

}
