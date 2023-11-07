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
    var todoList: [TodoList] = []
    lazy var items = BehaviorSubject(value: todoList)
    
    
    
    
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
    
    
    private func bind() {
        
        
        
        items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.identifier , cellType: ShoppingCollectionViewCell.self)) { row, element, cell in
                cell.listLabel.text = element.title
                
                cell.checkValue.onNext(element.check)
                cell.starValue.onNext(element.star)
                
                cell.checkButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let value = element.check
                        owner.todoList[row].check.toggle()
                        owner.items.onNext(owner.todoList)
                        cell.checkValue.onNext(!value)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.checkValue
                    .map {
                        $0 ? Constants.Image.fillCheck : Constants.Image.emptyCheck
                    }
                    .bind(with: self) { owner, image in
                        cell.checkImg.onNext(image)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.checkImg
                    .bind(to: cell.checkButton.rx.image())
                    .disposed(by: cell.disposeBag)
                
                cell.starButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let value = element.star
                        owner.todoList[row].star.toggle()
                        owner.items.onNext(owner.todoList)
                        cell.checkValue.onNext(!value)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.starValue
                    .map {
                        $0 ? Constants.Image.fillStar : Constants.Image.emptyStar
                    }
                    .bind(with: self) { owner, image in
                        cell.starImg.onNext(image)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.starImg
                    .bind(to: cell.starButton.rx.image())
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        
        
        
        mainView.addButton.rx.tap
            .withLatestFrom(mainView.addTextField.rx.text.orEmpty, resultSelector: { _, text in
                return text
            })
            .bind(with: self, onNext: { owner, value in
                if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    let list = TodoList(title: value)
                    owner.todoList.insert(list, at: 0)
                    owner.items.onNext(owner.todoList)
                }
                
            })
            .disposed(by: disposeBag)
        
        // 실시간 검색
        mainView.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                let result = value == "" ? owner.todoList : owner.todoList.filter{ $0.title.contains(value) }
                owner.items.onNext(result)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(mainView.collectionView.rx.itemSelected, mainView.collectionView.rx.modelSelected(TodoList.self))
            .bind(with: self) { owner, data in
                
                let vc = EditViewController()
                vc.title = data.1.title
                vc.todo = data.1
                vc.editHandler = { editType, value in
                    switch editType {
                    case .none:
                        print(data.0.row)
                    case .delete:
                        owner.todoList.remove(at: data.0.row)
                        owner.items.onNext(owner.todoList)
                    case .update:
                        owner.todoList[data.0.row].title = value ?? ""
                       
                        owner.items.onNext(owner.todoList)
                        
                    }
                }
                
                owner.navigationController?.pushViewController(vc, animated: true)
                
               
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
}

