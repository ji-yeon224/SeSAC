//
//  BeerCollectionViewCell.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BeerCollectionViewCell"
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        beerImageView.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 17)
    }

}
