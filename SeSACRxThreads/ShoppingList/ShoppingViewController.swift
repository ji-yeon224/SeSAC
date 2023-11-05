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
    
    var data = ["신발", "커피", "양말", "자켓", "아아", "아야"]
    lazy var items = BehaviorSubject(value: data)
    
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.titleView = mainView.searchBar
        bind()
    }
    
    let check = BehaviorSubject(value: false)
    
    private func bind() {
        
        
        
        items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.identifier , cellType: ShoppingCollectionViewCell.self)) { row, element, cell in
                cell.listLabel.text = element
                
                cell.check
                    .bind(with: self) { owner, value in
                        let img = value ? Constants.Image.fillCheck : Constants.Image.emptyCheck
                        cell.checkImg.onNext(img)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.checkButton.rx.tap
                    .bind(with: self) { owner, _ in
                        cell.checkState.toggle()
                        cell.check.onNext(cell.checkState)
//                        cell.checkState.toggle()
//                        let img = cell.checkState ? Constants.Image.fillCheck : Constants.Image.emptyCheck
//                        cell.checkButton.setImage(img, for: .normal)
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
                if !value.trimmingCharacters(in: .whitespaces).isEmpty{
                    owner.data.insert(value, at: 0)
                    owner.items.onNext(owner.data)
                }
                
            })
            .disposed(by: disposeBag)
        
        // 실시간 검색
        mainView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                let result = value == "" ? owner.data : owner.data.filter{ $0.contains(value) }
                owner.items.onNext(result)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(mainView.collectionView.rx.itemSelected, mainView.collectionView.rx.modelSelected(String.self))
            .bind(with: self) { owner, value in
                
                let vc = EditCellViewController()
                vc.title = value.1
                vc.data = (value.0[1], value.1)
                vc.editHandler = { value in
                   
                }
                
                owner.navigationController?.pushViewController(vc, animated: true)
                
               
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
}

