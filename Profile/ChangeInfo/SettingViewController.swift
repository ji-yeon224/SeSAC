//
//  SettingViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

extension NSNotification.Name {
    static let changeGender = NSNotification.Name("changeGender")
}

class SettingViewController: BaseViewController {
    
    let mainView = ChangeInfoView()
    var settingList: ProfileSetting?
    
    var delegate: PassNameDelegate?
    
    var completionHandler: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        mainView.textField.becomeFirstResponder()
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        switch settingList {
        case .name:
            completionHandler?(mainView.textField.text!)
        case .userName:
            delegate?.receiveData(name: mainView.textField.text!)
        case .gender:
            NotificationCenter.default.post(name: .changeGender, object: nil, userInfo: ["gender": mainView.textField.text!])
        case .introduce:
            delegate?.receiveData(name: mainView.textField.text!)
        case .link:
            delegate?.receiveData(name: mainView.textField.text!)
        default: print("default")
        }
        
        
        
    }
    
    @objc func doneButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func configureView() {
        super.configureView()
        mainView.label.text = settingList?.rawValue
        mainView.textField.placeholder = settingList!.rawValue + " 입력"
    }
    
    override func setConstraints() {
        
    }
    
    
    
}


