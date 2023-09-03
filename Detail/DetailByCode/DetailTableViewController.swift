//
//  DetailTableViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func didSelectRowAt(indexPath: IndexPath)
}

class DetailTableViewController: BaseViewController {
    
    
    
    let mainView = DetailView()
    override func loadView() {
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailTableViewController: DetailViewProtocol {
    func didSelectRowAt(indexPath: IndexPath) {
        print(indexPath)
    }
}
