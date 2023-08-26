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
    
    //var contentsList: [Contents] = []
    var genreDictionary: [Int : String] = [:]
    var creditList: [Credit] = []
    var castList: [String] = []
    
    var trendList: [ContentsData] = []
    
    let group = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        

        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        setCell()
        callTrendData(type: type.typeString, time: time)
        title = "THIS WEEK ALL TREND"
        timeButton.setTitle("DAY", for: .normal)
        setMenuButton()
        getGenreData(type: Type.movie.typeString)
        getGenreData(type: Type.tv.typeString)
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
            
        }
        
    }
    
    func setMenuButton() {
        var menuItems: [UIAction] = []
        for gen in typeList {
            let action = UIAction(title: gen.rawValue, image: UIImage(systemName: "folder")) { (action) in
                self.callTrendData(type: Type(rawValue: action.title)!.typeString, time: self.time)
                switch self.time {
                case .week:
                    self.title = "TODAY \(action.title.uppercased()) TREND"
                case .day:
                    self.title = "THIS WEEK \(action.title.uppercased()) TREND"
                }
                
            }
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
    
    func callTrendData(type: String, time: Time) {
        trendList.removeAll()
        let parameter = "\(type)/\(time.rawValue)"
        group.enter()
        TMDBApi.shared.callTrendingRequest(endPoint: .trend, parameter: parameter) { trend in
          
            self.trendList.append(contentsOf: trend.results)
            //print(self.trendList)
            
            self.collectionView.reloadData()
            self.group.leave()
        }
    }
  
    

    
    func getGenreData(type: String) {
        
        group.enter()
        TMDBApi.shared.callRequest(endPoint: .genre, parameter: type) { json in
            let data = json["genres"].arrayValue
            for item in data {
                self.genreDictionary[item["id"].intValue] = item["name"].stringValue
                
            }
            
            self.collectionView.reloadData()
            self.group.leave()
        }
        
        
    }
    

}

//collectionView
extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as! TrendCollectionViewCell
        
        let trendData = trendList[indexPath.row]
        
        
        if trendData.posterPath.count == 0 {
            cell.posterImage.image = UIImage(systemName: "xmark")!
            cell.posterImage.tintColor = .lightGray
        } else {
            let imageURL = TMDBApi.imgURL + trendData.posterPath
            let url = URL(string: imageURL)!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)

                }
            }
        }
        
        var genreString = ""
        for i in trendData.genreIDS {
            genreString += "#\(genreDictionary[i] ?? "") "

        }
        cell.genreLabel.text = genreString
        cell.titleLabel.text = trendData.title
        cell.originalTitleLabel.text = trendData.originalTitle
        
        switch trendData.mediaType {
        case .tv:
            cell.titleLabel.text = trendData.name
            cell.releaseLabel.text = ""
        case .movie:
            cell.titleLabel.text = trendData.title
            cell.releaseLabel.text = trendData.releaseDate
        
        }


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        let trendData = trendList[indexPath.row]
        
        //vc.contents = trendData
        vc.trendData = trendData
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func setCell() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)


        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing


        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
    }
    
    
}
