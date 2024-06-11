//
//  DetailViewController.swift
//  iTunesApp
//
//  Created by 김지연 on 11/12/23.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    
    var appInfo: AppInfo? = nil
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appInfo = appInfo else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        title = appInfo.trackName
        
    }
    
    override func config() {
        super.config()
    }
    
}
