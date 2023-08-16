//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/16.
//

import UIKit
import Alamofire

class CodableViewController: UIViewController {
    
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    
    
    var resultText = "Apple"

    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchLottoData()
        fetchTranslateData(source: "ko", target: "en", text: "안녕하세요")
        
        fetchTranslateData(source: "en", target: "ko", text: resultText)
    }

    func fetchTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("확인", self.resultText)
                self.fetchTranslate(source: "en", target: "ko", text: self.resultText)
                
            }

    }
    
    func fetchTranslate(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("최종 확인", self.resultText)
                
            }

    }
    
    
    
    

//    func fetchLottoData() {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//
//
//        DispatchQueue.global().async {
//            AF.request(url, method: .get).validate()
//                .responseData { response in
//                    guard let value = response.value else { return }
//                    print("responseData:", value)
//
//
//
//                }
//        }
//
//
//
//
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//                print(value.bnusNo, value.drwtNo3)
//            }
//
//    }

}

struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}


struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}
