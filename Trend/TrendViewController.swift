//
//  TrendViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON

class TrendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var contentsList: [Contents] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        setCell()
        getTrendData()
        
    }
    
    func getTrendData () {
//        let movieList = TMDBApi.shared.getTrendAPI(time: "week", genre: "movie")
//        print(movieList)
        let list = TMDBApi.shared.callRequest(type: .trend, genre: "movie", time: "week") { json in
            let data = json["results"].arrayValue
            for item in data {
                //print(item)
                self.contentsList.append(Contents.init(
                    id: item["id"].intValue,
                    title: item["title"].stringValue,
                    overview: item["overview"].stringValue,
                    poster: item["poster_path"].stringValue,
                    release: item["release_date"].stringValue))
                
            }
            //print(self.movieList)
            self.collectionView.reloadData()
        }
        
        print(list)
        
        
    }
    
  
}

//collectionView
extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as! TrendCollectionViewCell
        
        print(contentsList[indexPath.row].poster)
        let url = URL(string: "https://image.tmdb.org/t/p/original"+contentsList[indexPath.row].poster)!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.posterImage.image = UIImage(data: data)
                
            }
        }
        cell.titleLabel.text = contentsList[indexPath.row].title
        

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        vc.contents = contentsList[indexPath.row]
        present(vc, animated: true)
    }
    
    func setCell() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 22
        let width = UIScreen.main.bounds.width - (spacing * 2)
        print(width, UIScreen.main.bounds.width)


        layout.itemSize = CGSize(width: width - 10, height: width * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        

        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
    }
    
    
}
