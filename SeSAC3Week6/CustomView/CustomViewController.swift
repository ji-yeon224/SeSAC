//
//  CustomViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/24.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {
    
    let idTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "아이디를 입력해주세요"
        return view
    }()

    let passwordTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "비밀번호를 입력해주세요"
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            <#code#>
        }

    }
    

}
