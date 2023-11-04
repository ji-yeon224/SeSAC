//
//  ShoppingViewController.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/4/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ShoppingViewController: UIViewController {
    
    let mainView = ShoppingView()
    
    var data = ["A", "BBBBBBBBBB", "C", "D"]
    lazy var items = BehaviorSubject(value: data)
    
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "쇼핑"
        view.backgroundColor = .white
        
        bind()
    }
    
    private func bind() {
        
        items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.identifier , cellType: ShoppingCollectionViewCell.self)) { row, element, cell in
                cell.listLabel.text = element
                cell.checkButton.rx.tap
                    .bind(with: self) { owner, _ in
                        cell.checkState.toggle()
                        let img = cell.checkState ? Constants.Image.fillCheck : Constants.Image.emptyCheck
                        cell.checkButton.setImage(img, for: .normal)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.starButton.rx.tap
                    .bind(with: self) { owner, _ in
                        cell.starState.toggle()
                        let img = cell.starState ? Constants.Image.fillStar : Constants.Image.emptyStar
                        cell.starButton.setImage(img, for: .normal)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        mainView.addButton.rx.tap
            .withLatestFrom(mainView.addTextField.rx.text.orEmpty, resultSelector: { _, text in
                return text
            })
            .bind(with: self, onNext: { owner, value in
                owner.data.insert(value, at: 0)
                owner.items.onNext(owner.data)
            })
            .disposed(by: disposeBag)
        
        
        
        
    }
    
    
    
    
}

