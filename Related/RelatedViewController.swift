//
//  RelatedViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/18.
//

import UIKit

class RelatedViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    var contentList: [cont] = []
    var contentsData: [ContentsData] = []
    let group = DispatchGroup()
    var videosList: Videos = Videos(id: 0, results: [])
    var selectedSegmentIdx = 0
    var contentId: Int?
    var mediaType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "More Videos"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        print(contentId, mediaType)
        
        let nib = UINib(nibName: RelatedCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RelatedCollectionViewCell.identifier)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControlChanged(segmentedControl)
        setCellLayout()
        
        segmentedControl.setTitle("similiar", forSegmentAt: 0)
        segmentedControl.setTitle("videos", forSegmentAt: 1)

        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedSegmentIdx = 0
            if contentList.isEmpty {
                callSimilarData(id: contentId!, mediaType: mediaType!)
                callSimilarContent(id: contentId!, mediaType: mediaType!)
            }
        case 1:
            selectedSegmentIdx = 1
            if videosList.results.isEmpty{
                callVideoData(id: contentId!, mediaType: mediaType!)
            }
            
            
            
        default:
            print("segmentControl Index error")
        }
        group.notify(queue: .main){
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(.zero, animated: true)
        }
        
    }
}

extension RelatedViewController {
    
    func callSimilarContent(id: Int, mediaType: String) {
        TMDBApi.shared.callTrendingRequest(endPoint: .similar, parameter: "\(mediaType)/\(id)") { content in
            self.contentsData.append(contentsOf: content.results)
            print(self.contentsData)
        }
    }
    
    func callSimilarData(id: Int, mediaType: String) {
        
        group.enter()
        TMDBApi.shared.callRequest(endPoint: .similar, parameter: "movie/671") { json in

            let data = json["results"].arrayValue
            for item in data {
                let id = item["id"].intValue
                let overview = item["overview"].stringValue
                let poster = item["poster_path"].stringValue
                let media_type = item["media_type"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let originalTitle = item["originalTitle"].stringValue
                var genre: [Int] = []
                for g in item["genre_ids"].arrayValue {
                    genre.append(g.intValue)
                }

                var title = ""
                var release = ""

                switch mediaType {
                case "tv":
                    title = item["name"].stringValue
                    release = ""
                case "movie":
                    title = item["title"].stringValue
                    release = item["release_date"].stringValue
                    //print(title)
                default: return
                }

                self.contentList.append(cont(id: id, title: title, originalTitle: originalTitle, overview: overview, poster: poster, backdrop_path: backdrop, release: release, media_type: media_type, genre: genre))
                
            }
            self.group.leave()

        }
       
        
    }
        
        func callVideoData(id: Int, mediaType: String) {
            group.enter()
            TMDBApi.shared.callVideoRequest(endPoint: .videos, parameter: "\(mediaType)/\(id)") { data in
                self.videosList = data
                self.group.leave()
            }
           
        }
        
    
}



extension RelatedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSegmentIdx == 0 {
            return contentList.count
        }else {
            return videosList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedCollectionViewCell.identifier, for: indexPath) as! RelatedCollectionViewCell

        if selectedSegmentIdx == 0 {
            let contents = contentList[indexPath.row]
            cell.titleLabel.text = contents.title
            cell.releaseLabel.text = contents.release
            
            if contents.poster.count == 0 {
                cell.imageView.backgroundColor = .lightGray
                cell.imageView.image = nil
            } else {
                let imgURL = TMDBApi.imgURL + contents.poster
                
                if let url = URL(string: imgURL) {
                    DispatchQueue.global().async {
                        let data = try! Data(contentsOf: url)
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: data)
                            
                        }
                    }
                } else {
                    cell.imageView.image = UIImage(systemName: "person")
                    cell.imageView.tintColor = .lightGray
                }
            }
            
            
            
        
        } else {
            
            let video = videosList.results[indexPath.row]
            if video.site == "YouTube" {
                let thumbnailURL = "https://img.youtube.com/vi/\(video.key)/0.jpg"
                
                if let url = URL(string: thumbnailURL) {
                    DispatchQueue.global().async {
                        let data = try! Data(contentsOf: url)
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: data)
                            
                        }
                    }
                } else {
                    cell.imageView.image = UIImage(systemName: "person")
                    cell.imageView.tintColor = .lightGray
                }
                
                
            } else {
                cell.imageView.backgroundColor = .lightGray
            }
            cell.titleLabel.text = video.name
            if video.publishedAt.count == 0 {
                cell.releaseLabel.text = ""
            }else {
                cell.releaseLabel.text = video.publishedAt
            }
            }
            
        

        return cell
    }
   
    
    
    func setCellLayout() {
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
