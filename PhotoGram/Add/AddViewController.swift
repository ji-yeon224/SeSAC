//
//  ViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() {
        self.view = mainView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver),
                                               name: NSNotification.Name("SelectImage"), object: nil)
        
        
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function)
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        present(SearchViewController(), animated: true)
    }
    
    override func configureView() { // addSubView baseViewController viewDidLoad 시점에 호출됨
        print("Add ConfigureView")
        super.configureView()
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
    }
    
    override func setConstraints() { // 제약조건
        print("Add SetConstraints")
        super.setConstraints()
        
        
    }


}

