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
    
    let items = BehaviorSubject(value: ["aqa", "eee", "cdddfdfadsfa"])
    
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
        mainView.datePickerView.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    
    private func bind() {
        
        items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: RankCollectionViewCell.identifier, cellType: RankCollectionViewCell.self)) { row, element, cell in
                cell.rankLabel.text = "1"
                cell.titleLabel.text = element
                cell.totalCount.text = "12344568"
            }
            .disposed(by: disposeBag)
        
        
        
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        mainView.dateTextField.text = DateFormatter.convertDate(date: sender.date)
    }
    
    
}
