//
//  SeSACShop.swift
//  SeSACTest
//
//  Created by 김지연 on 12/18/23.
//

import Foundation
import StoreKit

class SeSACShop: ObservableObject {
    
    @Published var allProducts: [Product] = [] // 인앱 상품 조회 (SKProductsRequestDelegate로 얻어오는 정보)
    
    func fetchAllProducts() async {
        
        do {
            let product = try await Product.products(for: [
                "com.jiyeon.test.premium",
                "com.jiyeon.test.RemoveAd"
            ])
            allProducts = product
            
        } catch {
            print(error)
        }
        
    }
}
