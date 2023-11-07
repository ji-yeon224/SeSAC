//
//  ViewController.swift
//  SeSACRxSummery
//
//  Created by jack on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout() )
    let searchBar = UISearchBar()
    
    let disposeBag = DisposeBag()
    
    let items = PublishSubject<[DailyBoxOfficeList]>() //Observable.just(["테스트1", "테스트2", "테스트3"])
    let array = Array<String>()
    let array2: [String] = []
    let recent = BehaviorRelay(value: []) //Observable.just(["테스트4", "테스트5", "테스트6"])
    
    var nickname = BehaviorSubject(value: "고래밥")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    func bind() {
       
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.movieNm) \(element.openDt)"
            }
            .disposed(by: disposeBag)
        
        recent
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "MovieCollectionCell", cellType: MovieCollectionViewCell.self)) { (row, element, cell) in
                cell.label.text = "\(element) @ row \(row)"
                
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(searchBar.rx.text.orEmpty, resultSelector: { _, value in
                return value
            })
            .map { text -> String in
                guard let newText = Int(text) else { return "20231106" }
                return String(newText)
            }
            .flatMap {
                BoxOfficeNetwork.fetchBoxOfficeData(date: $0)
            }
            .subscribe(with: self, onNext: { owner, movie in
                let data = movie.boxOfficeResult.dailyBoxOfficeList
                owner.items.onNext(data)
            })
            .disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(DailyBoxOfficeList.self), tableView.rx.itemSelected)
            .map { $0.0.movieNm }
            .debug()
            .subscribe(with: self) { owner, value in
                let data = owner.recent.value + [value]
                owner.recent.accept(data)
                
            }
            .disposed(by: disposeBag)
    }
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.backgroundColor = .green
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        collectionView.backgroundColor = .red
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
     
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
   
}
