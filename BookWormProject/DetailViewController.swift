//
//  DetailViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

    var movieInfo: Movie!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseInfoLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieInfo else {
            return
        }
        
        backView.backgroundColor = .systemGray6
        backView.layer.opacity = 80
        
        title = movieInfo.title
        titleLabel.text = movieInfo.title
        posterImageView.image = UIImage(named: movieInfo.title)
        releaseInfoLabel.text = "\(movieInfo.releaseDate) | \(movieInfo.runtime)분"
        
        overviewTextView.text = movieInfo.overview
        overviewTextView.font = .systemFont(ofSize: 15)
        overviewTextView.isEditable = false
        overviewTextView.backgroundColor = .clear
        
        changeLikeButton(like: movieInfo.like)
        
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        movieInfo.like.toggle()
        changeLikeButton(like: movieInfo.like)
    }
    
    func changeLikeButton(like: Bool){
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
