//
//  TrendCollectionViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit
import Alamofire

enum Time: String {
    case week
    case day
}

class TrendCollectionViewController: BaseViewController {
    
    let mainView = TrendView()
    
    override func loadView() {
        self.view = mainView
    }
    
    var session: URLSession!
    
    var time: Time = .week
    var type: Type = .all
    var typeList = Type.allCases
    
    var genreDictionary: [Int : String] = [:]
    var creditList: [Credit] = []
    var castList: [String] = []
    
    var trendList: [ContentsData] = []
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "THIS WEEK ALL TREND"
        //setCell()
        setMenuButton()
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
        //callTrendData(type: type.typeString, time: time)
        callURLSessionTrend(type: type.typeString, time: time)
        if genreDictionary.isEmpty {
            callGenreData(type: Type.tv.typeString)
            callGenreData(type: Type.movie.typeString)
        }
        
        group.notify(queue: .main) {
            //self.mainView.collectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .top, animated: true)
            print("noti")
            self.mainView.collectionView.reloadData()
            
        }
        
    }
    
    func setMenuButton() {
        var menuItems: [UIAction] = []
        for gen in typeList {
            let action = UIAction(title: gen.rawValue, image: UIImage(systemName: "folder")) { (action) in
                self.callURLSessionTrend(type: Type(rawValue: action.title)!.typeString, time: self.time)
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "WEEK", style: .plain, target: self, action: #selector(timeChangeButtonClicked))
    }
    
    @objc func timeChangeButtonClicked() {
        switch time {
        case .week:
            time = .day
            title = "TODAY \(type.rawValue) TREND"
            navigationItem.rightBarButtonItem?.title = "DAY"
        case .day:
            time = .week
            title = "THIS WEEK \(type.rawValue) TREND"
            navigationItem.rightBarButtonItem?.title = "WEEK"
        }
        
        callURLSessionTrend(type: type.typeString, time: time)
    }
    
    
}

extension TrendCollectionViewController {
    
    func callURLSessionTrend(type: String, time: Time) {
        trendList.removeAll()
        let parameter = "\(type)/\(time.rawValue)"
        group.enter()
        URLSessionAPI.shared.callTrendRequestURLSession(endPoint: .trend, parameter: parameter) { trend in
            guard let trend = trend else {
                print("error")
                return
            }
            self.trendList.append(contentsOf: trend.results)
            self.mainView.collectionView.reloadData()
            self.group.leave()
        }
    }
    
    func callTrendData(type: String, time: Time) {
        trendList.removeAll()
        let parameter = "\(type)/\(time.rawValue)"
        group.enter()
        TMDBApi.shared.callTrendingRequest(endPoint: .trend, parameter: parameter) { trend in
          
            self.trendList.append(contentsOf: trend.results)
            self.mainView.collectionView.reloadData()
            self.group.leave()
        }
    }
  
    func callGenreData(type: String) {
        group.enter()
        TMDBApi.shared.callGenreRequest(endPoint: .genre, parameter: type) { genre in
            
            for item in genre.genres {
                self.genreDictionary[item.id] = item.name
                
            }
            self.group.leave()
        }
    }
}

extension TrendCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionCell.identifier, for: indexPath) as? TrendCollectionCell else { return UICollectionViewCell() }
        
        
        let trendData = trendList[indexPath.row]
        
        
        if trendData.posterPath.count == 0 {
            cell.imageView.image = UIImage(systemName: "xmark")!
            cell.imageView.tintColor = .lightGray
        } else {
            let imageURL = TMDBApi.imgURL + trendData.posterPath
            let url = URL(string: imageURL)!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)

                }
            }
        }
        
        var genreString = ""
        for i in trendData.genreIDS {
            genreString += "#\(genreDictionary[i] ?? "") "

        }
        cell.genreLabel.text = genreString
        cell.titleLabel.text = trendData.title
        //cell.originalTitleLabel.text = trendData.originalTitle
        
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
        
        vc.trendData = trendData
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

//extension TrendCollectionViewController: URLSessionDelegate{
//
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
//
//    }
//
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//    }
//
//}
