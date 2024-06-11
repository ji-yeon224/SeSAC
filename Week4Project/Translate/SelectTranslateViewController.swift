//
//  SelectTranslateViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

enum Langs: String, CaseIterable {
    case 한국어 = "ko"
    case 일본어 = "ja"
    case 중국어 = "zh-CN"
    case 영어 = "en"
    case 스페인어 = "es"
    
    var langType: String {
        String(describing: self)
    }
    
}

class SelectTranslateViewController: UIViewController {
    
    let placeholder = "번역할 내용을 입력하세요."
    
    @IBOutlet var sourceTextField: UITextField!
    @IBOutlet var targetTextField: UITextField!
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var requestButton: UIButton!
    
    let langList = Langs.allCases
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalTextView.delegate = self
       
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
       
        
        designProperties()
        
        
        
    }
    
    func designProperties() {
        
        originalTextView.text = placeholder
        originalTextView.textColor = .lightGray
        translateTextView.text = ""
        translateTextView.isEditable = false
        
        originalTextView.layer.borderWidth = 1
        originalTextView.layer.borderColor = UIColor.lightGray.cgColor
        originalTextView.layer.cornerRadius = 10
        originalTextView.font = .systemFont(ofSize: 20)
        
        translateTextView.layer.borderWidth = 1
        translateTextView.layer.borderColor = UIColor.lightGray.cgColor
        translateTextView.layer.cornerRadius = 10
        translateTextView.font = .systemFont(ofSize: 20)
        
        sourceTextField.inputView = pickerView
        sourceTextField.text = "한국어"
        targetTextField.inputView = pickerView
        targetTextField.text = "영어"
        
        requestButton.setTitle("Translate", for: .normal)
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        translateText(source: getRawValue(sourceTextField.text!), target: getRawValue(targetTextField.text!), text: originalTextView.text)
        
    }
    
    func getRawValue(_ caseValue: String) -> String {
        
        switch caseValue {
        case "한국어": return "ko"
        case "일본어": return "ja"
        case "중국어": return"zh-CN"
        case "영어": return "en"
        case "스페인어": return "es"
        default: return ""
        }
        
    }
    

}


extension SelectTranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return langList[row].langType
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            sourceTextField.text = langList[row].langType
        } else {
            targetTextField.text = langList[row].langType
        }
    }
  
    
    
}

extension SelectTranslateViewController {
    
    func translateText(source: String, target: String, text: String) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "\(APIKey.naverID)",
            "X-Naver-Client-Secret" : "\(APIKey.naverKey)"
        ]
        
        let parameter: Parameters = [
            "source": source ?? "ko",
            "target": target ?? "en",
            "text": text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translateTextView.text = data
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}

extension SelectTranslateViewController: UITextViewDelegate {
    

    //편집이 시작될 때(커서가 시작될 때)
    //placdholder와 textview의 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if placeholder == textView.text {
            textView.text = nil
            textView.textColor = .black
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


