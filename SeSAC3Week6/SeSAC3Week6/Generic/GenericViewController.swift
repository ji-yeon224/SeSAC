//
//  GenericViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/24.
//

import UIKit
import SnapKit

class GenericViewController: UIViewController {
    
    let sampleLabel = UILabel()
    let sampleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        title = "네비게이션 타이틀"
        view.addSubview(sampleLabel)
        sampleLabel.backgroundColor = .yellow
        configureBorder(view: sampleLabel)
        sampleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(sampleButton)
        sampleButton.backgroundColor = .green
        configureBorder(view: sampleButton)
        sampleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.height.equalTo(50)
        }

        let value1 = sum(a: 3, b: 7)//sumInt(a: 3, b: 7)
        print(value1)
        
        let value2 = sumDouble(a: 3.5, b: 7.7)
        print(value2)
    }
    
    
}
