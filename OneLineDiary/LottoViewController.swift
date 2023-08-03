//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/08/03.
//

import UIKit

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var numberTextField: UITextField!
    
    let pickerView = UIPickerView() //생성
    
    
    
    var list: [Int] = Array(1...1111).reversed()
    //Array(repeating: 100, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self

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
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
   

}
