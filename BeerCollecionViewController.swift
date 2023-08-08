//
//  BeerCollecionViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher



class BeerCollecionViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var beerList: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "맥주 리스트"

        collectionView.dataSource = self
        collectionView.delegate = self
        
        customCollectionCell()
        
        let nib = UINib(nibName: "BeerCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
        
        callRequest()
    }
    
    func callRequest() {
        
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let beerInfoList = json.arrayValue
                
                
                for beer in beerInfoList {
                   
                    self.beerList.append(Beer.init(name: beer["name"].stringValue ,
                                                   img: beer["image_url"].stringValue,
                                                   description: beer["description"].stringValue))
                    
                }
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}


extension BeerCollecionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func customCollectionCell() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 30
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        
        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier, for: indexPath) as! BeerCollectionViewCell
        
        
        cell.beerImageView.kf.setImage(with: URL(string: beerList[indexPath.row].img))
        cell.nameLabel.text = beerList[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        vc.beer = beerList[indexPath.row]
       
        present(vc, animated: true)
    }
    
}
