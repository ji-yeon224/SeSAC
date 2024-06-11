//
//  Extension+Alert.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //저장 버튼의 기능을 구현하기 위해 closure 사용! outlet action 연결이 어려우니까..
        let button = UIAlertAction(title: button, style: .default) { action in
            
            completionHandler() //함수에 있는 기능을 밖에서 구현할 수 있다
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(button)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
}
