//
//  SnapViewController.swift
//  SeSAC3Week6
//
//  Created by 김지연 on 2023/08/22.
//

import UIKit
import SnapKit

class SnapViewController: UIViewController {
    
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(redView)
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.width.equalTo(200) // width 200
            make.height.equalTo(150) // height 150
            make.centerX.equalTo(view) // view의 중앙에
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(whiteView)
        
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.equalTo(view.safeAreaLayoutGuide)
//            make.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        view.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.snp.makeConstraints { make in
            //make.centerX.centerY.equalTo(view)
            make.center.equalTo(view)
            //make.width.height.equalTo(200)
            make.size.equalTo(200)
        }
        
        blueView.addSubview(yellowView)
        yellowView.backgroundColor = .yellow
        yellowView.snp.makeConstraints { make in
//            make.size.equalTo(50)
//            make.leading.top.equalToSuperview()
            
//            make.leading.top.trailing.bottom.equalToSuperview()
            make.edges.equalTo(blueView).inset(50)
        }
        
    }
    

}
