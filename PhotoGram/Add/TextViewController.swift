//
//  TextViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class TextViewController: BaseViewController {
    let textView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) {
        completionHandler?(textView.text)
    }
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }
}
