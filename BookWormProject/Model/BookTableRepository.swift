//
//  BookTableRepository.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/09/06.
//

import Foundation
import RealmSwift

protocol BookTableRepositoryType: AnyObject {
    func fetch() -> Results<BookTable>
    //func fetchFilterByMemo() -> Results<BookTable>
    func createItem(_ item: BookTable)
    func deleteItem(_ item: BookTable)
    func updateItem(id: ObjectId, memo: String)
}

class BookTabelRepository: BookTableRepositoryType {
    
    private let realm = try! Realm()
    
    func fetch() -> Results<BookTable> {
        return realm.objects(BookTable.self)
    }
    
    func createItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(id: ObjectId, memo: String) {
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "memo": memo] as [String : Any], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
}
