//
//  VideoViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Video{
    
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String
    
    //연산 프로퍼티
    var contents: String {
        get {
            return "\(author) | \(time)회\n\(date)"
        }
    }
    
}

class VideoViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: [Video] = []
    var page = 1
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티

    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.rowHeight = 130
        videoTableView.prefetchDataSource = self
        
        searchBar.delegate = self
        
        
    }
    
    
    func callRequest(query: String, page: Int) {
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=10&page=\(page)"
        let header: HTTPHeaders =  ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        
        print(url)
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    print(self.isEnd)
                    
                    for item in json["documents"].arrayValue {
                        
                        let author = item["author"].stringValue
                        let date = item["datetime"].stringValue
                        let time = item["play_time"].intValue
                        let thumbnail = item["thumbnail"].stringValue
                        let title = item["title"].stringValue
                        let link = item["url"].stringValue
                        
                        let data = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
                        
                        self.videoList.append(data)
                    }
                    
                    self.videoTableView.reloadData()
                    //print(self.videoList)
                } else {
                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요!!")
                }
                
                
                
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

   

}

extension VideoViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {return}
        videoList.removeAll()
        page = 1 //새로운 검색어이기 때문에 page를 1로 변경
        callRequest(query: query, page: page)
    }
    
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell()}
        
        
        cell.titleLabel.text = videoList[indexPath.row].title
        cell.contentLabel.text = videoList[indexPath.row].contents
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        
        return cell
    }
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //videoList개수와 indexPath.row의 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd { //현 위치랑 리스트의 개수를 비교
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
        
        
    }
    //취소기능: 직접 취소하는 기능을 구현해줘야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
    
}
