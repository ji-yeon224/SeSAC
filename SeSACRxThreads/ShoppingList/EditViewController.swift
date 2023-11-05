//
//  EditViewController.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit

final class EditViewController: UIViewController {
    
    var data: (Int, String)?
    var editHandler: ((EditType, (Int, String)) -> Void)?
    
    let mainView = EditView()
    
    override func loadView() {
        self.view = mainView
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
    }
    
    func configure() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.Image.back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func deleteButtonTapped() {
        
        guard let data = data else {
            navigationController?.popViewController(animated: true)
            return
        }
        editHandler?(.delete, (data.0, data.1))
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc private func backButtonTapped() {
        guard let data = data else {
            navigationController?.popViewController(animated: true)
            return
        }
        editHandler?(.none, (data.0, data.1))
        navigationController?.popViewController(animated: true)
        
    }
    
}
