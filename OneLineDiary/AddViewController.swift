//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        title = "추가화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = .yellow
        
        
    }
    
    @objc
    func closeButtonClicked() {
        
        //present - dismiss / push - pop 으로 화면 전환 코드의 짝을 맞춰야 한다.
        dismiss(animated: true) //화면이 사라지는 코드
        
        
    }


}

