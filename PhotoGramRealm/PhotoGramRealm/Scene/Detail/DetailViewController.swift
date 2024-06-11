//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by 김지연 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    var data: DiaryTable?
    let realm = try! Realm()
    let repository = DiaryTableRepository()
    
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        view.textColor = Constants.BaseColor.text
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        view.textColor = Constants.BaseColor.text
        return view
    }()
    
    override func configure() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        
        guard let data = data else { return }
        
        titleTextField.text = data.diaryTitle
        contentTextField.text = data.contents
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
    }
    override func setConstraints() {
        super.setConstraints()
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
        
    }
    
    @objc func editButtonClicked() {
        guard let data = data else { return }
        
        repository.updateItem(id: data._id, title: titleTextField.text!, contents: contentTextField.text!)
        
        navigationController?.popViewController(animated: true)
    }
    
   
    
}
