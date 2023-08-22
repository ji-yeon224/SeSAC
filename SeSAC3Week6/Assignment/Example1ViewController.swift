//
//  Example1ViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit
import SnapKit

class Example1ViewController: UIViewController {
    
    let topView = UIView()
    let firstTextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        return view
    }()
    
    let secondTextField = {
        
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜를 입력해주세요"
        view.textAlignment = .center
        return view
        
    }()
    let bottomView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for item in [topView, firstTextField, secondTextField, bottomView] {
            view.addSubview(item)
        }
        setConstraints()

    }
    
    func setConstraints() {
        topView.backgroundColor = .gray
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo( -20)
            make.height.equalTo(view).multipliedBy(0.35)
        }
        
        
        firstTextField.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(20)
            make.height.equalTo(40)
        }
        
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(firstTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(20)
            make.height.equalTo(40)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(secondTextField.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(20)
            
        }
        
    }
    

    

}
