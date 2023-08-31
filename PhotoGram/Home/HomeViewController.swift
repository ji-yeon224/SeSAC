//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/31.
//

import UIKit


protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    override func loadView() {
        let view = HomeView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print(self, #function)
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}
