//
//  TrendViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON

enum Time: String {
    case week
    case day
}

class TrendViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeButton: UIButton!
    
    var time: Time = .week
    var genre: Genre = .all
    var genreList = Genre.allCases
    
    var contentsList: [Contents] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        collectionView.dataSource = self
        collectionView.delegate = self
        

        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        setCell()
        getTrendData(genre: genre.genreString, time: time)
        title = "THIS WEEK TREND"
        timeButton.setTitle("DAY", for: .normal)
        setMenuButton()
        print(Genre(rawValue: "All"))
        
        
    }
    
    func setMenuButton() {
        var menuItems: [UIAction] = []
        for gen in genreList {
            let action = UIAction(title: gen.rawValue, image: UIImage(systemName: "trash")) { (action) in
                self.getTrendData(genre: Genre(rawValue: action.title)!.genreString, time: self.time)}
            menuItems.append(action)
            genre = Genre(rawValue: action.title)!
        }
        

        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: menu)
    }
    
    func changeGenreButton() {
        
    }
    
    @IBAction func timeChageButtonClicked(_ sender: Any) {
        switch time {
        case .week:
            time = .day
            title = "TODAY TREND"
            timeButton.setTitle("DAY", for: .normal)
        case .day:
            time = .week
            title = "THIS WEEK TREND"
            timeButton.setTitle("WEEK", for: .normal)
        }
        getTrendData(genre: genre.genreString, time: time)
        
        
    }
    
  
    
}

extension TrendViewController {
    func getTrendData (genre: String, time: Time) {
        contentsList.removeAll()
        TMDBApi.shared.trendCallRequest(type: .trend, genre: genre, time: time.rawValue) { json in
            let data = json["results"].arrayValue
            for item in data {
                self.contentsList.append(Contents.init(
                    id: item["id"].intValue,
                    title: item["title"].stringValue,
                    overview: item["overview"].stringValue,
                    poster: item["poster_path"].stringValue,
                    release: item["release_date"].stringValue))
                
            }
            self.collectionView.reloadData()
        }
        
        
        
        
    }
}

//collectionView
extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as! TrendCollectionViewCell
        
        
        if contentsList[indexPath.row].poster.count == 0 {
            cell.posterImage.image = UIImage(systemName: "xmark")!
            cell.posterImage.tintColor = .lightGray
        } else {
            let imageURL = TMDBApi.imgURL + contentsList[indexPath.row].poster
            let url = URL(string: imageURL)!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)
                    
                }
            }
        }
        
       
        
        
        
        cell.titleLabel.text = contentsList[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        vc.contents = contentsList[indexPath.row]
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func setCell() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 22
        let width = UIScreen.main.bounds.width - (spacing * 2)


        layout.itemSize = CGSize(width: width - spacing, height: width * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        

        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
    }
    
    
}
