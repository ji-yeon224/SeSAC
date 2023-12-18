//
//  StoreView.swift
//  SeSACTest
//
//  Created by 김지연 on 12/18/23.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    
    @StateObject var shop = SeSACShop()
    
    var body: some View {
        VStack {
            HStack {
                Text("광고 제거")
                Spacer()
                Button("$999.99") {
                    print("구매 버튼 클릭")
                }
            }.padding()
            ForEach(shop.allProducts, id: \.id) { item in
                ProductView(item) // ios 17~
                    .productViewStyle(.compact)
                
            }
            
        }
        .task { // onAppear 대신
            await shop.fetchAllProducts()
        }
    }
}

#Preview {
    StoreView()
}
