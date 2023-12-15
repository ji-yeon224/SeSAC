//
//  InAppPurchaseController.swift
//  SeSACTest
//
//  Created by 김지연 on 12/15/23.
//

import UIKit
import StoreKit

class InAppPurchaseController: UIViewController {
    
    @IBOutlet var productLabel: UILabel!
    
    // 1. 인앱 상품 ID 정의
    var productIdentifier: Set<String> = ["com.jiyeon.test.RemoveAd"]
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // 2. productIdentifier에 정의된 상품 ID 정보 가져오기 + 사용자의 디바이스가 인앱 결제 가능한지
    func reqeustProductData() {
        
        // 결제가 가능한 기기인지 체크
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            
            // 3. 인앱 상품 조회
            let request = SKProductsRequest(productIdentifiers: productIdentifier)
            request.delegate = self
            request.start()
            
        } else {
            print("In App Purchage Not Enabled")
        }
    }
    
    @IBAction func buyButtonClicked(_ sender: Any) {
        // 5. 구매 버튼 클릭
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
        
        
    }
}

extension InAppPurchaseController: SKProductsRequestDelegate {
    
    // 4. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count > 0 {
            for item in products {
                productArray.append(item)
                product = item
                
                print(item.productIdentifier)
                print(item.localizedTitle)
                print(item.price)
                print(item.priceLocale)
            }
        }
        
    }
    
    
}

// SKPaymentTransactionObserver: 구매 승인, 취소에 대한 프로토콜
extension InAppPurchaseController: SKPaymentTransactionObserver {
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        
        // 구매 영수증 정보
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
        
    }
    
    
    // update transaction
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("구매하는 중")
            case .purchased:
                print("구매 완료 상태")
                print(transaction.payment.productIdentifier) // 구매가 완료 되었는지 구매 상품 확인
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed:
                print("구매 실패")
                SKPaymentQueue.default().finishTransaction(transaction) // 트랜잭션 종료
            case .restored:
                print("구매 복원")
            default:
                print("default")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("remove transaction")
    }
    
}
