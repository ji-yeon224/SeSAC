//
//  LottoViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/13.
//

import UIKit


class LottoViewController: UIViewController {
    
    let pickerView = UIPickerView()
    
    
    @IBOutlet var drwNoTextField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var num1Label: UILabel!
    @IBOutlet var num2Label: UILabel!
    @IBOutlet var num3Label: UILabel!
    @IBOutlet var num4Label: UILabel!
    @IBOutlet var num5Label: UILabel!
    @IBOutlet var num6Label: UILabel!
    @IBOutlet var bnusLabel: UILabel!
    
    @IBOutlet var moneyLabel: UILabel!
    
    let viewModel = LottoViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drwNoTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        bindData()
        
        viewModel.fetchLottoNum()
//        viewModel.presentTitle()
//        viewModel.presentTotal()
    }
    
    func bindData() {
        viewModel.drwNo.bind { value in
            self.titleLabel.text = "\(value)"
        }
        viewModel.titleText.bind { value in
            self.titleLabel.text = value
        }
        viewModel.num1.bind { value in
            self.num1Label.text = "\(value)"
        }
        viewModel.num2.bind { value in
            self.num2Label.text = "\(value)"
        }
        viewModel.num3.bind { value in
            self.num3Label.text = "\(value)"
        }
        viewModel.num4.bind { value in
            self.num4Label.text = "\(value)"
        }
        viewModel.num5.bind { value in
            self.num5Label.text = "\(value)"
        }
        viewModel.num6.bind { value in
            self.num6Label.text = "\(value)"
        }
        viewModel.bnsNo.bind { value in
            self.bnusLabel.text = "\(value)"
        }
        viewModel.drwNo.bind { value in
            self.drwNoTextField.text = "\(value)"
        }
        
        viewModel.totalText.bind { value in
            self.moneyLabel.text = "\(value)"
        }
    }
    
    
    
}
    

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.lottoNoList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        viewModel.drwNo.value = viewModel.lottoNoList[row]
        viewModel.fetchLottoNum()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(viewModel.lottoNoList[row])"
    }
    
}
