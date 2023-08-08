//
//  BeerRecViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class BeerRecViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.font = .boldSystemFont(ofSize: 20)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 17)
        
        callRequest()
        
        
        
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        callRequest()
    }
    
    
    func callRequest() {
       
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let imgUrl = "\(json[0]["image_url"].stringValue)"
               
                self.imageView.kf.setImage(with: URL(string: imgUrl))
                
                self.nameLabel.text = json[0]["name"].stringValue
                self.descriptionLabel.text = json[0]["description"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
