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
    var type: Type = .all
    var typeList = Type.allCases
    
    var contentsList: [Contents] = []
    var genreDictionary: [Int : String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        

        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        setCell()
        getTrendData(type: type.typeString, time: time)
        title = "THIS WEEK ALL TREND"
        timeButton.setTitle("DAY", for: .normal)
        setMenuButton()
        getGenreData(type: Type.movie.typeString)
        getGenreData(type: Type.tv.typeString)
        
    }
    
    func setMenuButton() {
        var menuItems: [UIAction] = []
        for gen in typeList {
            let action = UIAction(title: gen.rawValue, image: UIImage(systemName: "folder")) { (action) in
                self.getTrendData(type: Type(rawValue: action.title)!.typeString, time: self.time)}
            menuItems.append(action)
            type = Type(rawValue: action.title)!
        }
        

        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: menu)
    }
  
    
    @IBAction func timeChangeButtonClicked(_ sender: Any) {
        switch time {
        case .week:
            time = .day
            title = "TODAY \(type.rawValue) TREND"
            timeButton.setTitle("DAY", for: .normal)
        case .day:
            time = .week
            title = "THIS WEEK \(type.rawValue) TREND"
            timeButton.setTitle("WEEK", for: .normal)
        }
        
        
        
    }
    
  
    
}

extension TrendViewController {
    func getTrendData (type: String, time: Time) {
        contentsList.removeAll()
        let parameter = "\(type)/\(time.rawValue)"
        TMDBApi.shared.callRequest(endPoint: .trend, parameter: parameter) { json in
            let data = json["results"].arrayValue
            for item in data {
                let id = item["id"].intValue
                let overview = item["overview"].stringValue
                let poster = item["poster_path"].stringValue
                let media_type = item["media_type"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                var genre: [Int] = []
                for g in item["genre_ids"].arrayValue {
                    genre.append(g.intValue)
                }
                
                var title = ""
                var release = ""


                switch media_type {
                case "tv":
                    title = item["name"].stringValue
                    release = ""
                case "movie":
                    title = item["title"].stringValue
                    release = item["release_date"].stringValue
                default: return
                }

                
                self.contentsList.append(Contents(id: id, title: title, overview: overview, poster: poster, backdrop_path: backdrop, release: release, media_type: media_type, genre: genre))
            }
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(.zero, animated: true)
        }

    }
    
    func getGenreData(type: String) {
        
        
        TMDBApi.shared.callRequest(endPoint: .genre, parameter: type) { json in
            let data = json["genres"].arrayValue
            for item in data {
                self.genreDictionary[item["id"].intValue] = item["name"].stringValue
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
        
        cell.releaseLabel.text = contentsList[indexPath.row].release
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
        
        var genreString = ""
        for i in contentsList[indexPath.row].genre {
            genreString += "#\(genreDictionary[i] ?? "") "

        }
        cell.genreLabel.text = genreString
        cell.titleLabel.text = "\(indexPath.row + 1). " + contentsList[indexPath.row].title

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
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 2)


        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing


        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
    }
    
    
}
