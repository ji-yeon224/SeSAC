//
//  TodoList.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/7/23.
//

import Foundation
import RxDataSources

struct TodoList: SectionModelType {
    typealias Item = Todo
    
    var section: String
    var items: [Item]
}

extension TodoList {
    init(original: TodoList, items: [Todo]) {
        self = original
        self.items = items
    }
}

struct Todo {
    
    var title: String
    var check: Bool = false
    var star: Bool = false
    
    
    
}
