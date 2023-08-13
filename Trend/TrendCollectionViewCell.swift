//
//  TrendCollectionViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.backgroundColor = .black
        posterImage.contentMode = .scaleAspectFill
        
        
    }

}
