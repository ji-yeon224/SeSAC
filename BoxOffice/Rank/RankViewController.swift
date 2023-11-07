//
//  RankViewController.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa

final class RankViewController: BaseViewController {
    
    let mainView = RankView()
    var data: [DailyBoxOfficeList] = []
    lazy var items = BehaviorSubject(value: data)
    
    var dateString = DateFormatter.convertDate(date: Date())
    lazy var date = BehaviorRelay(value: dateString)
    lazy var request = APIManager.shared.requestRank(api: .dailyBoxoffice(date: dateString))
        .asDriver(onErrorJustReturn: RankingModel(boxOfficeResult: Results( dailyBoxOfficeList: [])))
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configure() {
        super.configure()
        view.backgroundColor = .secondarySystemBackground
        mainView.datePickerView.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    private func bind() {
        
        items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: RankCollectionViewCell.identifier, cellType: RankCollectionViewCell.self)) { row, element, cell in
                cell.rankLabel.text = element.rank
                cell.titleLabel.text = element.title
                cell.totalCount.text = NumberFormatter.convertDecimalType(num: element.audiAcc)
                cell.dailyCount.text = NumberFormatter.convertDecimalType(num: element.audiCnt)
            }
            .disposed(by: disposeBag)
        
        
        
        request
            .drive(with: self) { owner, result in
                owner.data.append(contentsOf: result.boxOfficeResult.dailyBoxOfficeList)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        
        mainView.datePickerView.rx.date
            .distinctUntilChanged()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map { DateFormatter.convertDate(date: $0) }
            .bind(with: self, onNext: { owner, value in
                owner.date.accept(value)
            })
            .disposed(by: disposeBag)
        
        date
            .flatMap {
                APIManager.shared.requestRank(api: .dailyBoxoffice(date: $0))
            }
            .bind(with: self) { owner, ranking in
                owner.data.removeAll()
                owner.data.append(contentsOf: ranking.boxOfficeResult.dailyBoxOfficeList)
                owner.items.onNext(owner.data)
                
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        mainView.dateTextField.text = DateFormatter.convertDate(date: sender.date)
    }
    
    
}
