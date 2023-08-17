//
//  VideoViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher





class VideoViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    //var videoList: [Video] = []
    var videoList: Video = Video(documents: [])
    var page = 1
    var isEnd = false //현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.rowHeight = 130
        //videoTableView.prefetchDataSource = self
        
        searchBar.delegate = self
        
        //callRequest(query: "아이유", page: 1)
    }
    
    
    func callRequest(query: String, page: Int) {
        
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { data in
            
            self.videoList = data
            print(self.videoList)
            self.videoTableView.reloadData()
        }
        
    }
    
}



extension VideoViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {return}
        //videoList.removeAll()
        page = 1 //새로운 검색어이기 때문에 page를 1로 변경
        callRequest(query: query, page: page)
    }
    
}


extension VideoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell()}
        
        let video = videoList.documents[indexPath.row]
        
        cell.titleLabel.text = video.title
        cell.contentLabel.text = video.contents
        if let url = URL(string: video.thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        
        return cell
    }
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    //videoList개수와 indexPath.row의 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//        for indexPath in indexPaths {
//            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd { //현 위치랑 리스트의 개수를 비교
//                page += 1
//                callRequest(query: searchBar.text!, page: page)
//            }
//        }
//
//
//    }
    //취소기능: 직접 취소하는 기능을 구현해줘야 함
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        print("===취소: \(indexPaths)")
//    }
    
}
