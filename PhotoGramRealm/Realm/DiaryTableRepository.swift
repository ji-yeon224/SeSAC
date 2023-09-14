//
//  DiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by 김지연 on 2023/09/06.
//

import Foundation
import RealmSwift

protocol DiaryTableRepositoryType: AnyObject {
    func fetch() -> Results<DiaryTable>
    func fetchFilterPhoto() -> Results<DiaryTable>
    func createItem(_ item: DiaryTable)
    func deleteItem(_ item: DiaryTable)
}

class DiaryTableRepository: DiaryTableRepositoryType {
    
    private let realm = try! Realm()
    
    private func a() { // => 다른 파일에서 쓸 일 없고, 클래스 안에서만 쓸 수 있음 => 오버라이딩 불가능
        
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("schema version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<DiaryTable> { // 전체 반환
        let data = realm.objects(DiaryTable.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        return data
    }
    
    func fetchFilterPhoto() -> Results<DiaryTable> {
        let result = realm.objects(DiaryTable.self).where {
            $0.photo != nil
        }
        return result
    }
    
    func createItem(_ item: DiaryTable) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
        
    }
    
    func updateItem(id: ObjectId, title: String, contents: String ) {
        do {
            try realm.write {
                realm.create(DiaryTable.self, value: ["_id": id, "diaryTitle": title, "diaryContent": contents] as [String : Any], update: .modified)
                
            }
        } catch {
            print("") //nslog
        }
    }
    
    func deleteItem(_ item: DiaryTable) {
        
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    
}
