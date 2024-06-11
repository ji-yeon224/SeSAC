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
    var contentsData: [SimilarResult] = []
    let group = DispatchGroup()
    var videosList: Videos = Videos(id: 0, results: [])
    var selectedSegmentIdx = 0
    var contentId: Int?
    var mediaType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        title = "More Videos"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
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
        group.enter()
        TMDBApi.shared.callSimilarRequest(endPoint: .similar, parameter: "\(mediaType)/\(id)") { content in
           
            self.contentsData.append(contentsOf: content.results)
            self.group.leave()
        }
    }
    
      
        func callVideoData(id: Int, mediaType: String) {
            group.enter()
            TMDBApi.shared.callVideoRequest(endPoint: .videos, parameter: "\(mediaType)/\(id)") { data in
                self.videosList = data
                //print(data)
                self.group.leave()
            }
           
        }
        
    
}



extension RelatedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSegmentIdx == 0 {
            return contentsData.count
        }else {
            return videosList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedCollectionViewCell.identifier, for: indexPath) as! RelatedCollectionViewCell

        if selectedSegmentIdx == 0 {
            let contents = contentsData[indexPath.row]
            cell.titleLabel.text = contents.title
            cell.releaseLabel.text = contents.releaseDate
            
            if contents.posterPath == nil {
                cell.imageView.backgroundColor = .lightGray
                cell.imageView.image = nil
            } else {
                let imgURL = TMDBApi.imgURL + contents.posterPath!
                
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videosList.results[indexPath.row]
        if selectedSegmentIdx == 1 {
            if video.site == "YouTube" {
                let youtubeURL = "https://www.youtube.com/watch?v=\(video.key)"
                let url = URL(string: youtubeURL) ?? URL(string: "https://www.youtube.com")
                let vc = YoutubeViewController()
                vc.url = url
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .overFullScreen
                present(nav, animated: true)
                
            }
        }
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
