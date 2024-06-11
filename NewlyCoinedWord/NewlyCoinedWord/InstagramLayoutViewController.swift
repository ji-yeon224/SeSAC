//
//  InstagramLayoutViewController.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/23.
//

import UIKit

class InstagramLayoutViewController: UIViewController {

    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var profileShareButton: UIButton!
    
    @IBOutlet var profileEditButton: UIButton!
    
    @IBOutlet var findButton: UIButton!
    
    
    @IBOutlet var infoLabels: [UILabel]!
    
    @IBOutlet var infoCountLabels: [UILabel]!
    
    @IBOutlet var postedImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designProperties()

    }
    
    func designProperties() {
        
        profileImageView.layer.cornerRadius = 20
        
        for info in infoLabels {
            info.font = UIFont.systemFont(ofSize: 13)
            info.textAlignment = .center
        }
        for count in infoCountLabels {
            count.font = UIFont.boldSystemFont(ofSize: 15)
            count.textAlignment = .center
            
        }
        
        findButton.tintColor = .darkGray
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .darkGray
        config.baseForegroundColor = .white
        config.cornerStyle = .fixed
        config.titleAlignment = .center
        config.titlePadding = 8
        config.title = "프로필 편집하기"
        profileEditButton.configuration = config
        config.title = "프로필 공유하기"
        profileShareButton.configuration = config
        
        for img in postedImageViews {
            img.layer.borderWidth = 1
            img.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    


}
