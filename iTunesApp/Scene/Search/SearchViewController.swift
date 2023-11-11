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
    
    
    
    let data: [AppInfo] = []
    lazy var items = BehaviorRelay(value: data)
    private let disposeBag = DisposeBag()
    
    
    private let mainView = SearchView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        updateSnapShot()
        bind()
    }
    
    func bind() {
        
        let request = APIManager.shared.search(term: "todo")
            .asDriver(onErrorJustReturn: ITunesSearch(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, value in
                owner.items.accept(value.results)
                owner.updateSnapShot()
            }
            .disposed(by: disposeBag)
    }
    
    func config() {
        view.backgroundColor = .white
    }
    
    private func updateSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, AppInfo>()
        snapShot.appendSections([0])
        snapShot.appendItems(items.value)
        mainView.dataSource.apply(snapShot)
    }
    
    
}
