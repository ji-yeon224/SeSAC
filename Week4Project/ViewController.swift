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
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.rowHeight = 60
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        callRequest()
    }

    
    func callRequest() {
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20120101"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let movieInfoList = json["boxOfficeResult"]["dailyBoxOfficeList"]
                
                for item in movieInfoList.arrayValue {
                    self.movieList.append(Movie.init(title: item["movieNm"].stringValue, release: item["openDt"].stringValue))
                }
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        
        
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
