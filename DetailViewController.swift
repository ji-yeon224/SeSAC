//
//  DetailViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    var beer: Beer? = nil
    
    @IBOutlet var beerDetailImageView: UIImageView!
    @IBOutlet var beerDetailDescriptionLabel: UILabel!
    @IBOutlet var beerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        beerDetailDescriptionLabel.numberOfLines = 0
        
       
        
        beerDetailImageView.kf.setImage(with: URL(string: beer!.img))
        beerDetailDescriptionLabel.text = beer!.description
        beerNameLabel.text = beer!.name
        beerNameLabel.font = .boldSystemFont(ofSize: 20)
        beerNameLabel.textAlignment = .center
    }
    
   

}
