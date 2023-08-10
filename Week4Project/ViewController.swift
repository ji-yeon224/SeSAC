//
//  ViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/07.
//

import UIKit
import SwiftyJSON
import Alamofire


struct Movie {
    
    var title: String
    var release: String
    
}

class ViewController: UIViewController {

    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.rowHeight = 60
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        indicatorView.isHidden = true
        
    }

    
    func callRequest(date: String) {
        
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let movieInfoList = json["boxOfficeResult"]["dailyBoxOfficeList"]
                
                for item in movieInfoList.arrayValue {
                    self.movieList.append(Movie.init(title: item["movieNm"].stringValue, release: item["openDt"].stringValue))
                }
                
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }

}

extension ViewController: UISearchBarDelegate {
    
    //검색 버튼 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //20220101 -> 1. 8글자 2. 20233333 올바른 날짜 3. 날짜 범주
        
        callRequest(date: searchBar.text!)
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.detailTextLabel?.text = movieList[indexPath.row].release
        
        return cell
    }
    
    
}
