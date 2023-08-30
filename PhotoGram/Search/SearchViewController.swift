//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit



class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark","person.circle"]
    var delegate: PassImageDelegate?
    
    override func loadView() {
        self.view = mainView
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver), name: NSNotification.Name("RecommendKeyword"), object: nil)
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self

    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }
   

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
    }
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageList[indexPath.item])
        
        //protocol 값 전달
        
        delegate?.receiveImgData(img: UIImage(systemName: imageList[indexPath.item])!)
        
        //notification을 통한 값 전달
//        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"),
//                                        object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "고래밥"])
        
        dismiss(animated: true)
        //navigationController?.popViewController(animated: true)
    }
}

