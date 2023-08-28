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
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var castLabel: UILabel!
    
    let genreDic = UserDefaults.standard.dictionary(forKey: "genreList")
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.backgroundColor = .black
        posterImage.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        
        releaseLabel.font = .systemFont(ofSize: 15)
        releaseLabel.textColor = .darkGray
        
        genreLabel.font = .boldSystemFont(ofSize: 17)
        genreLabel.numberOfLines = 0
        
        originalTitleLabel.font = .systemFont(ofSize: 17)
        originalTitleLabel.numberOfLines = 0
        
        castLabel.font = .systemFont(ofSize: 15)
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
