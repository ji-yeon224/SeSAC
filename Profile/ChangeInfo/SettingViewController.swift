//
//  SettingViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let mainView = ChangeInfoView()
    var settingList: ProfileSetting?
    
    var delegate: PassNameDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.receiveData(name: mainView.textField.text!)
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


