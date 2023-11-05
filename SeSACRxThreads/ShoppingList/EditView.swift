//
//  EditView.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit
import SnapKit

enum EditType {
    case update, delete, none
}

final class EditView: UIView {
    
    let deleteButton = {
        let view = UIButton()
        view.setTitle("Delete", for: .normal)
        view.backgroundColor = Constants.Color.cellColor
        view.layer.cornerRadius = 5
        view.setTitleColor(.black, for: .normal)
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
    }
    
    private func setConstraints() {
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
    }
}
