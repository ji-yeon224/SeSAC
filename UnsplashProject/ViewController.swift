//
//  ViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var changeButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.placeholder = NSLocalizedString("nickname_placeholder", comment: "")
        
//
//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "고래밥", "다마고치", "칙촉")
        
        resultLabel.text = "age_result".localized(number: 26)
        
        let searchbar = UISearchBar()
        searchbar.text = "adf"
        searchbar.placeholder = "asds"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    


}

