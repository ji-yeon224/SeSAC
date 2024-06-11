//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/11/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "\(Int.random(in: 1...100))"
        
    }
    
    
}


class SearchViewController: UIViewController {
     
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let searchBar = UISearchBar()
    
    var data: [AppInfo] = []
    // = ["A", "B", "안", "아니", "아", "C", "AB", "D", "ABC"]
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
        //setSearchController()
    }
     
    func bind() {
        
        items // cellForRowAt
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackName
                cell.appIconImageView.backgroundColor = .green
                
                cell.downloadButton.rx.tap
                    
                    .subscribe(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(SampleViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        let request = BasicAPIManager.fetchData()
            .asDriver(onErrorJustReturn: SearchAppModel(resultCount: 0, results: []))
        
        request
            .drive(with: self) { owner, result in
                owner.items.onNext(result.results)
            }
            .disposed(by: disposeBag)
        
        request
            .map { data in
                "\(data.results.count)개의 검색 결과"
            }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
            
        
//        tableView.rx.itemSelected
//            .subscribe(with: self) { owner, indexPath in
//                print(indexPath)
//            }
//            .disposed(by: disposeBag)
//        
//        tableView.rx.modelSelected(String.self)
//            .subscribe(with: self) { owner, indexPath in
//                print(indexPath)
//            }
//            .disposed(by: disposeBag)
        
//        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self))
//            .map{ "셀 선택 \($0) \($1)" }
//            //.bind(to: navigationItem.rx.title)
//            .subscribe(with: self) { owner, value in
//                print(value)
//            }
//            .disposed(by: disposeBag)
//        
//        
//        // SearchBar text를 배열에 추가 -> 리턴 키 클릭 시
//        // text 옵셔널 바인딩 처리 -> append -> reloadData
//        // SearchVarDelegate searchButtonClicked
//        
//        searchBar.rx.searchButtonClicked
//            .withLatestFrom(searchBar.rx.text.orEmpty) { void, text in  // void -> 클릭 액션 반환 값
//                return text
//            }
//            .subscribe(with: self, onNext: { owner, value in
//                owner.data.insert(value, at: 0)
//                owner.items.onNext(owner.data)
//            })
//            .disposed(by: disposeBag)
//        
//        
//        
//        searchBar.rx.text.orEmpty
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged() // 직전 데이터와 같다면 무시함
//            .subscribe(with: self) { owner, value in
//                let result = value == "" ? owner.data : owner.data.filter{ $0.contains(value) }
//                owner.items.onNext(result)
//                
//                print("==실시간 검색== \(value)")
//            }
//            .disposed(by: disposeBag)
//        

    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
