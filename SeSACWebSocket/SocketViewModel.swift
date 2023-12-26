//
//  SocketViewModel.swift
//  SeSACWebSocket
//
//  Created by 김지연 on 12/26/23.
//

import Foundation
import Combine

final class SocketViewModel: ObservableObject {
    
    @Published
    var askOrderBook: [OrderbookItem] = []
    
    @Published
    var bidOrderBook: [OrderbookItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        WebSocketManager.shared.openWebSocket()
        
        WebSocketManager.shared.send() // request
        
        
        //RxSwift Dispose vs AnyCancellable
        //RxSwift Schedular vs Combine receive
        //RxSwift Subscribe vs Combine sink
        WebSocketManager.shared.orderBookSbj
            .receive(on: DispatchQueue.main)
            .sink { [weak self] order in
                guard let self else { return }
                self.askOrderBook = order.orderbookUnits
                    .map { .init(price: $0.askPrice, size: $0.askSize) }
                    .sorted { $0.price > $1.price }
                self.bidOrderBook = order.orderbookUnits
                    .map { .init(price: $0.bidPrice, size: $0.bidSize) }
                    .sorted { $0.price > $1.price }
            }
            .store(in: &cancellable)
        
    }
    
    deinit {
        WebSocketManager.shared.closeWebSocket()
    }
    
    
}
