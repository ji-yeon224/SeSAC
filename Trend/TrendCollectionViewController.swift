//
//  TrendCollectionViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class TrendCollectionViewController: BaseViewController {
    
    let mainView = TrendView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configureView() {
        super.configureView()
    }
    
}
