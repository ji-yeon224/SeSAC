//
//  BookModel.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var poster: String
    @Persisted var contents: String
    @Persisted var datetime: String
    @Persisted var publisher: String
    @Persisted var price: Int
    @Persisted var like: Bool
    @Persisted var memo: String?
    
    convenience init(title: String, author: String, poster: String, contents: String, datetime: String, publisher: String, price: Int) {
        self.init()
        
        self.title = title
        self.author = author
        self.poster = poster
        self.contents = contents
        self.datetime = datetime
        self.publisher = publisher
        self.price = price
        self.like = false
        self.memo = ""
        
        
    }
    
}
