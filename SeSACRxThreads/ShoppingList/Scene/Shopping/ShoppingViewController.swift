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
    
    let viewModel = ShoppingViewModel()
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
        
        let input = ShoppingViewModel.Input(
            addText: mainView.addTextField.rx.text.orEmpty,
            addButtonTap:  mainView.addButton.rx.tap,
            searchText: mainView.searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.format(input: input)
        
        output.items
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.identifier , cellType: ShoppingCollectionViewCell.self)) { row, element, cell in
                cell.listLabel.text = element.title
                
                cell.checkValue.onNext(element.check)
                cell.starValue.onNext(element.star)
                
                cell.checkButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let value = element.check
                        owner.viewModel.todoList[row].check.toggle()
                        owner.viewModel.updateTodo.accept(owner.viewModel.todoList)
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
                        owner.viewModel.todoList[row].star.toggle()
                        owner.viewModel.updateTodo.accept(owner.viewModel.todoList)
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
                        owner.viewModel.todoList.remove(at: data.0.row)
                        owner.viewModel.updateTodo.accept(owner.viewModel.todoList)
                    case .update:
                        owner.viewModel.todoList[data.0.row].title = value ?? ""
                       
                        owner.viewModel.updateTodo.accept(owner.viewModel.todoList)
                        
                    }
                }
                
                owner.navigationController?.pushViewController(vc, animated: true)
                
               
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
}

