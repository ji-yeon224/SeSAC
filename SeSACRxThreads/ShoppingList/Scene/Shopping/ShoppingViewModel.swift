//
//  ShoppingViewModel.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa


final class ShoppingViewModel {
    
    var todoList: TodoList = TodoList(section: "", items: [])
    lazy var updateTodo: BehaviorRelay<[TodoList]> = BehaviorRelay(value: [TodoList(section: "", items: [])])
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let addText: ControlProperty<String>
        let addButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let deleteItem: ControlEvent<IndexPath>
        
    }
    
    struct Output {
        
        let items: BehaviorRelay<[TodoList]>
        
    }
    
    func transform(input: Input) -> Output {
        
        
        
        input.addButtonTap
            .withLatestFrom(input.addText, resultSelector: { _, text in
                return text
            })
            .debug()
            .bind(with: self, onNext: { owner, value in
                if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    let list = Todo(title: value)
                    owner.todoList.items.insert(list, at: 0)
                    owner.updateTodo.accept([owner.todoList])
                }
                
            })
            .disposed(by: disposeBag)
        
        input.searchText
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                let result = value == "" ? owner.todoList.items : owner.todoList.items.filter { $0.title.contains(value) }
                owner.updateTodo.accept([TodoList(section: "", items: result)])
            }
            .disposed(by: disposeBag)
        
        input.deleteItem
            .bind(with: self) { owner, indexPath in
                owner.todoList.items.remove(at: indexPath.row)
                owner.updateTodo.accept([owner.todoList])
            }
            .disposed(by: disposeBag)
        
        
        return Output(items: updateTodo)
    }
    
    
}
