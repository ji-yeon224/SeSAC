//
//  ToDoTable.swift
//  PhotoGramRealm
//
//  Created by 김지연 on 2023/09/08.
//

import Foundation
import RealmSwift

class ToDoTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    // To Many Releationship
    @Persisted var detail: List<DetailTable>
    
    //To One Relationship: EmbeddedObject, 별도의 테이블이 생성되는 형태는 아님
    @Persisted var memo: Memo?
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        self.title = title
        self.favorite = favorite
    }
    
    
}

class DetailTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    @Persisted(originProperty: "detail") var mainTodo: LinkingObjects<ToDoTable>
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        self.detail = detail
        self.deadline = deadline
    }
    
}

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var datae: Date
    
    
    convenience init(content: String, datae: Date) {
        self.init()
        self.content = content
        self.datae = datae
    }
}
