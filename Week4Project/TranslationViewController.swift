//
//  TranslationViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {
    
    let placeholder = "번역할 내용을 입력하세요."
    
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    @IBOutlet var translateTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        originalTextView.text = ""
        translateTextView.text = ""
        translateTextView.isEditable = false
        originalTextView.delegate = self
        
        originalTextView.layer.borderWidth = 1
        originalTextView.layer.borderColor = UIColor.lightGray.cgColor
        originalTextView.layer.cornerRadius = 10
        translateTextView.layer.borderWidth = 1
        translateTextView.layer.borderColor = UIColor.lightGray.cgColor
        translateTextView.layer.cornerRadius = 10
        
        originalTextView.text = placeholder
        originalTextView.textColor = .lightGray
        
        requestButton.setTitle("Translate", for: .normal)
    }
    
    

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        detectLangs(text: originalTextView.text)
        
        
        
    }
    
    func translateLang(source: String, text: String) {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "\(APIKey.naverID)",
            "X-Naver-Client-Secret" : "\(APIKey.naverKey)"
            
        ]
        let parameters: Parameters = [
            "source": source,
            "target": "en",
            "text": text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func detectLangs(text: String){
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "\(APIKey.naverID)",
            "X-Naver-Client-Secret" : "\(APIKey.naverKey)"
            
        ]
        let parameter: Parameters = ["query" : text]
        var result = ""
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.translateLang(source: json["langCode"].stringValue, text: text)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    
}

extension TranslationViewController: UITextViewDelegate {
    

    //편집이 시작될 때(커서가 시작될 때)
    //placdholder와 textview의 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if placeholder == textView.text {
            textView.text = nil
            textView.textColor = .black
        } else {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }


    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}
