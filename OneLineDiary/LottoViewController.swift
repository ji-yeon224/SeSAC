//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var bonusNumberLabel: UILabel!
    let pickerView = UIPickerView() //생성
    
    
    
    var list: [Int] = Array(1...1111).reversed()
    //Array(repeating: 100, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1")
        print("2")
        
        callRequest(number: 1079)
        
        
        print("4")
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print("5")

    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)" //url -> 요청 보낼 링크 넣기
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                print("3")
                
                let date = json["drwNoDate"].stringValue //타입 명시
                let bonusNumber = json["bnusNo"].intValue
                
                print(date, bonusNumber)
                
                self.dateLabel.text = date
                self.bonusNumberLabel.text = "\(bonusNumber)번"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    //pickerview 분할
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //셀 몇개?
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select \(row)")
        numberTextField.text = "\(list[row])"
        
        callRequest(number: list[row])
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
   

}
