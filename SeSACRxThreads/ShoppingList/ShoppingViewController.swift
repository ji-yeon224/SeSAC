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
    let checkState = BehaviorSubject(value: false)
    let starState = BehaviorSubject(value: false)
    
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
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
}

