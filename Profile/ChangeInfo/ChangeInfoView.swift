//
//  ChangeNameView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class ChangeInfoView: BaseView {
 
    let view = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
 
    let textField = {
        let view = UITextField()
        view.clearButtonMode =  .whileEditing
        return view
    }()
    
    let label = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    let underLineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(view)
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(underLineView)
    }
    
    override func setConstraints() {
        view.snp.makeConstraints { make in
            
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(self).multipliedBy(0.1)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(view).multipliedBy(0.2)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.horizontalEdges.equalTo(view).inset(20)
            make.bottom.equalTo(view)
        }
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view).inset(20)
        }
    }
    
}
