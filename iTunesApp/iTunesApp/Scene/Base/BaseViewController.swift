//
//  BaseViewController.swift
//  iTunesApp
//
//  Created by 김지연 on 11/12/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        view.backgroundColor = Constants.Color.background
    }
    
}
