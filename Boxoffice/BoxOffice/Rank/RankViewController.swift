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
    
    private let mainView = RankView()
    private let disposeBag = DisposeBag()
    
    private let viewModel = RankViewModel()
    
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
        
        
        mainView.dateTextField.text = DateFormatter.convertDateByLine(date: DateFormatter.yesterdayDate())
    }
    
    private func bind() {
        
        let input = RankViewModel.Input(datepickerValue: mainView.datePickerView.rx.date)
        let output = viewModel.format(input: input)
        
        output.items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: RankCollectionViewCell.identifier, cellType: RankCollectionViewCell.self)) { row, element, cell in
                cell.rankLabel.text = element.rank
                cell.titleLabel.text = element.title
                cell.totalCount.text = NumberFormatter.convertDecimalType(num: element.audiAcc)
                cell.dailyCount.text = NumberFormatter.convertDecimalType(num: element.audiCnt)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    @objc private func dateChange(_ sender: UIDatePicker) {
        mainView.dateTextField.text = DateFormatter.convertDateByLine(date: sender.date)
    }
    
    
}
