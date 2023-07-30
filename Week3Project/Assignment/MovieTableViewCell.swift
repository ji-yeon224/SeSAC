//
//  MovieTableViewCell.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/30.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    static let identifier = "MovieCell"
    
    
    func configurationCell(row: Movie) {

        titleLabel.text = row.title
        titleLabel.font = .boldSystemFont(ofSize: 15)
        infoLabel.text = "\(row.releaseDate) | \(row.runtime) | \(row.rate)점"
        
        posterImageView.image = UIImage(named: row.title)
        
        
        overviewLabel.text = row.overview
        overviewLabel.textAlignment = .left
        
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 10
    }

}
