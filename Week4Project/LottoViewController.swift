//
//  LottoViewController.swift
//  Week4Project
//
//  Created by 김지연 on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    var list: [Int] = Array(1...1111).reversed()
    let pickerView = UIPickerView()
    
    @IBOutlet var lottoTextField: UITextField!
    @IBOutlet var lottoNumLabel: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(number: 1079)
        lottoTextField.text = String(1079)
        
        lottoTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func callRequest(number: Int) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 1...self.lottoNumLabel.count - 1 {
                    let varName = "drwtNo\(i)"
                    self.lottoNumLabel[i-1].text = "\(json[varName].intValue)"
                }
                self.lottoNumLabel[self.lottoNumLabel.count - 1].text = "\(json["bnusNo"].intValue)"
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottoTextField.text = "\(list[row])"
        callRequest(number: list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
    

}

