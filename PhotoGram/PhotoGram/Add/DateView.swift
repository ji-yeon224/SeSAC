//
//  DateView.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class DateView: BaseView {
    
    let datePickerView = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        
        return view
    }()
    
    
    override func configureView() {
        addSubview(self.datePickerView)
    }
    
    override func setConstraints() {
        
        datePickerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            
        }
        
    }
    
    
}
