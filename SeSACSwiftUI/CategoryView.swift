//
//  CategoryView.swift
//  SeSACSwiftUI
//
//  Created by 김지연 on 11/15/23.
//

import SwiftUI

struct Category: Hashable, Identifiable {
    var id = UUID()
    let name: String
    let count: Int
}

struct CategoryView: View {
    
    let category = [
        Category(name: "스릴러", count: 10),
        Category(name: "로맨스", count: 50),
        Category(name: "애니메이션", count: 34),
        Category(name: "애니메이션", count: 1),
        Category(name: "액션", count: 28),
        Category(name: "액션", count: 12)
    ]
    
    var body: some View {
        VStack {
            ForEach(category, id: \.id) { item in
                Text("\(item.name) \(item.count) 안녕하세요")
            }
        }
    }
}

#Preview {
    CategoryView()
}
