//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit



class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    var photo = Photo(total: 0, total_pages: 0, results: [])
    
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
    
    
    func callRequest(query: String) {
        APIService.shared.callRequestAlmofire(query: query) { photo in
            self.photo = photo
            self.mainView.collectionView.reloadData()
        }
        
    }
   

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder()
        if let query = searchBar.text {
            callRequest(query: query)
        }
        
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            searchBar.text = nil
            photo = Photo(total: 0, total_pages: 0, results: [])
            mainView.collectionView.reloadData()
        }
    }
    
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        //cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        DispatchQueue.global().async {
            let url = URL(string: self.photo.results[indexPath.row].urls.thumb)!
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(imageList[indexPath.item])
        
        DispatchQueue.global().async {
            let url = URL(string: self.photo.results[indexPath.row].urls.full)!
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.delegate?.receiveImgData(img: UIImage(data: data)!)
            }
        }
        
        
        dismiss(animated: true)
        //navigationController?.popViewController(animated: true)
    }
}

