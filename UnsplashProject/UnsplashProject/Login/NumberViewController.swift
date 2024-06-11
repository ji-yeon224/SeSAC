//
//  NumberViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel = NumberViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    private func bindData() {
        viewModel.number.bind { value in
            self.numberTextField.text = value
        }
        
        viewModel.result.bind { value in
            self.resultLabel.text = value
        }
        
    }
    
    @objc func numberTextFieldChanged() {
        viewModel.number.value = numberTextField.text
        viewModel.convertNumber()
        
    }
    
}
