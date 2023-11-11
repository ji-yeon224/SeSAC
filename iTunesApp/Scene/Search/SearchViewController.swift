//
//  SearchViewController.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    
    private let viewModel = SearchViewModel()
    private let mainView = SearchView()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        bind()
    }
    
    func bind() {
        
        let input = SearchViewModel.Input(searchButton: mainView.searchBar.rx.searchButtonClicked, searchText: mainView.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(with: self) { owner, data in
                owner.updateSnapShot(items: data)
            }
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.cancelButtonClicked
            .subscribe(with: self) { owner, _ in
                owner.updateSnapShot(items: [])
            }
            .disposed(by: disposeBag)
        
    }
    
    func config() {
        view.backgroundColor = .white
        navigationItem.titleView = mainView.searchBar
    }
    
    private func updateSnapShot(items: [AppInfo]) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, AppInfo>()
        snapShot.appendSections([0])
        snapShot.appendItems(items)
        mainView.dataSource.apply(snapShot)
    }
    
    
}


