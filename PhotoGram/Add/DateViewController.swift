//
//  DateViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    // protocol 값 전달 2
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // protocol 값 전달 3
        delegate?.receiveDate(date: mainView.datePickerView.date)
    }
    
}
