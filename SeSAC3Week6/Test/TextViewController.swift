//
//  TextViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
    // 익명함수 이용하기
    lazy var photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        
        return view
    }() // 이름 없는 함수 호출
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(photoImageView)
//        view.addSubview(titleTextField)
        
//        for item in [photoImageView, titleTextField] {
//            view.addSubview(item)
//        }
        
        [photoImageView, titleTextField].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
        
        
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3) // 높이가 뷰의 30퍼 차지한다
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            //make.leading.equalTo(view).inset(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    
    func setImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        
        return view
    }

}
