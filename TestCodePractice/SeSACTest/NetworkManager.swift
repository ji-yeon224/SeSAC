//
//  NetworkManager.swift
//  SeSACTest
//
//  Created by 김지연 on 12/13/23.
//

import Foundation
import Alamofire

protocol NetworkProvider {
    func fetchLotto(handler: @escaping (Lotto) -> Void)
}



// 네트워크 테스트를 할 때는, Mock 데이터를 통해 실제 네트워크 통신을 하지 않고 테스트를 진행하는 것이 적합

class NetworkManager: NetworkProvider {
    
    
    static let shared = NetworkManager()
    private init() { }
    
    
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1000"
    
    func fetchLotto(handler: @escaping (Lotto) -> Void) { // 실제 네트워크 통신을 진행하는 부분
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                handler(success)
            case .failure(let failure):
                print(failure)
            }
        }
        
        
    }
    
    // 테스트는 인터넷이 연결되어 있어야만 테스트 성공
}


struct Lotto: Codable {
    let drwNoDate: String
    let bnusNo, drwtNo1: Int
}
