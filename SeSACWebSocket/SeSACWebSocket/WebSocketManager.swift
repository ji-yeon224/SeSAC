//
//  WebSocketManager.swift
//  SeSACWebSocket
//
//  Created by 김지연 on 12/26/23.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    
    static let shared = WebSocketManager()
    
    private override init() {
        super.init()
    }
    
    private var timer: Timer? // 5초마다 ping을 하기 위해 생성
    private var webSocket: URLSessionWebSocketTask?
    private var isOpen = false // 소켓 연결 상태
    
    // RxSwift PublishSubject vs Combine
    var orderBookSbj = PassthroughSubject<OrderBookWS, Never>()
    
    func openWebSocket() {
        
        if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
            
            ping()
        }
        
        
    }
    
    func closeWebSocket() {
        
        //URLSessionWebSocketTask Enum Close Code
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        timer?.invalidate() // RunLoop
        timer = nil
        
        isOpen = false
        
    }
    
    // 소켓 연결 이후 send 통해서 원하는 데이터를 받기 위해 서버에게 보냄
    func send() {
        let string = """
            [{"ticket":"test"},{"type":"orderbook","codes":["KRW-BTC"]}]
        """

        webSocket?.send(.string(string), completionHandler: { error in
            if let error {
                print("send error, \(error)")
            }
        })
    }
    
    func receive() {
        
        if isOpen {
            webSocket?.receive(completionHandler: { [weak self] result in
                switch result {
                case .success(let success):
//                    print("receive success, \(success)")
                    
                    switch success {
                    case .data(let data):
                        if let decodedData = try? JSONDecoder().decode(OrderBookWS.self, from: data) {
                            print("receive \(decodedData)")
                            self?.orderBookSbj.send(decodedData) // RxSwift onNext vs Combine send
                        }
                    case .string(let string): print(string)
                    @unknown default: print("unknow")
                    }
                    
                case .failure(let failure):
                    print("receive failure, \(failure)")
                    self?.closeWebSocket() // 실패했다면 소켓을 닫기
                }
                self?.receive()
            })
        }
        
    }
    
    // 서버에 의해 연결이 끊어지지 않도록 주기적으로 ping을 서버에 보냄
    private func ping() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error in
                if let _ = error {
                    print("Ping Pong Error")
                } else {
                    print("Ping")
                }
            })
        })
        
    }
    
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    // didOpen: 웹 소켓이 연결이 되었는지 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket Open")
        isOpen = true
        receive()
    }
    
    // didClose: 웹소켓 연결이 해제 되었는지 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket Close")
        isOpen = false
    }
}
