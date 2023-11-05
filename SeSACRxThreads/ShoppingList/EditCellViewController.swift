//
//  EditCellViewController.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit

final class EditCellViewController: UIViewController {
    
    var data: (Int, String)?
    var editHandler: (((Int, String)) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        guard let data = data else {
            navigationController?.popViewController(animated: true)
            return
        }
        configure()
        print(data)
    }
    
    func configure() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.Image.back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func backButtonTapped() {
        guard let data = data else {
            navigationController?.popViewController(animated: true)
            return
        }
        editHandler?((data.0, data.1))
        navigationController?.popViewController(animated: true)
        
    }
    
}
