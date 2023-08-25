//
//  FirstViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "DetailImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let label = {
        let view = UILabel()
        view.text = "Detail Information"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
            
            
        }
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottomMargin).offset(100)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
    }
    

  

}
