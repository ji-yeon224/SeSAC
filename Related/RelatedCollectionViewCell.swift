//
//  RelatedCollectionViewCell.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/18.
//

import UIKit

class RelatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        releaseLabel.font = .systemFont(ofSize: 13)
        
        
    }

}
