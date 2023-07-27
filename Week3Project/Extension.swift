//
//  Extension.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/27.
//

import UIKit

extension UITableViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "타이틀", message: "message", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
}

extension UILabel {
    func configureTitleText() {
        self.textColor = .blue
        self.font = .boldSystemFont(ofSize: 20)
        self.textAlignment = .center
        
    }
}


