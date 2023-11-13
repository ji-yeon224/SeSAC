//
//  SearchViewController.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

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
            .bind(to: mainView.tableView.rx.items(dataSource: mainView.dataSource))
            .disposed(by: disposeBag)
        
        
//        Observable.zip(mainView.tableView.rx.itemSelected, mainView.tableView.rx.modelSelected(AppInfo.self))
//            .bind(with: self) { owner, value in
//                print(value.1)
//            }
//            .disposed(by: disposeBag)
        
    }
    
    func config() {
        view.backgroundColor = .white
        navigationItem.titleView = mainView.searchBar
    }

    
}


