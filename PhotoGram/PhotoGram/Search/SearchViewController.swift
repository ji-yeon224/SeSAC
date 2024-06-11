//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}


class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark","person.circle"]
    var delegate: PassImageDelegate?
    
    override func loadView() {
        mainView.delegate = self
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
        
    }
    
    
    func callRequest(query: String) {
        APIService.shared.callRequestAlmofire(query: query) { photo in
            self.mainView.photo = photo
            self.mainView.collectionView.reloadData()
        }
        
    }
   

}

extension SearchViewController: SearchViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        DispatchQueue.global().async {
            let url = URL(string: self.mainView.photo.results[indexPath.row].urls.full)!
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.delegate?.receiveImgData(img: UIImage(data: data)!)
            }
        }
        
        
        dismiss(animated: true)
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
            mainView.photo = Photo(total: 0, total_pages: 0, results: [])
            mainView.collectionView.reloadData()
        }
    }
    
}



