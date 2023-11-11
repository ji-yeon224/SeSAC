//
//  SearchViewController.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {
    
    private let mainView = SearchView()
    let data = ["aa", "dd"]
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        updateSnapShot()
        
    }
    
    func config() {
        view.backgroundColor = .white
    }
    
    private func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems(data)
        mainView.dataSource.apply(snapShot)
    }
    
    
}
