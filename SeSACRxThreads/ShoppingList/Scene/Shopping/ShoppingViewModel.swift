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
    
    var todoList: [TodoList] = []
    var updateTodo: BehaviorRelay<[TodoList]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let addText:  ControlProperty<String>
        let addButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        
        let items: BehaviorRelay<[TodoList]>
        
    }
    
    func format(input: Input) -> Output {
        
        
        
        input.addButtonTap
            .withLatestFrom(input.addText, resultSelector: { _, text in
                return text
            })
            .bind(with: self, onNext: { owner, value in
                if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    let list = TodoList(title: value)
                    owner.todoList.insert(list, at: 0)
                    owner.updateTodo.accept(owner.todoList)
                }
                
            })
            .disposed(by: disposeBag)
        
        input.searchText
            .debounce(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                let result = value == "" ? owner.todoList : owner.todoList.filter { $0.title.contains(value) }
                owner.updateTodo.accept(result)
            }
            .disposed(by: disposeBag)
        
        return Output(items: updateTodo)
    }
    
    
}
