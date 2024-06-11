//
//  EditView.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit
import SnapKit



final class EditView: UIView {
    
    let deleteButton = CustomButton(title: "Delete")
    let updateButton = CustomButton(title: "Save")
    
    let updateTextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하시겠어요?"
        return view
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        addSubview(deleteButton)
        addSubview(updateButton)
        addSubview(updateTextField)
        addSubview(lineView)
    }
    
    private func setConstraints() {
        
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(updateButton.snp.height).multipliedBy(1.3)
        }
        
        updateTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(updateButton.snp.leading).offset(-20)
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(updateTextField.snp.width)
            make.top.equalTo(updateTextField.snp.bottom)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(updateTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
    }
}
