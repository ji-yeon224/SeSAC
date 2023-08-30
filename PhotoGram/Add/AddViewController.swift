//
//  ViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/28.
//

import UIKit
import SeSACFramework

//protocol 값 전달 1.
protocol PassDataDelegate {
    func receiveDate(date: Date)
    
}

protocol PassImageDelegate {
    func receiveImgData(img: UIImage)
}


class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.callRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver),
                                               name: .selectImage, object: nil)
        //sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print(#function)
        
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": word.randomElement()!])
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    
    override func configureView() { // addSubView baseViewController viewDidLoad 시점에 호출됨
        print("Add ConfigureView")
        super.configureView()
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.textViewButton.addTarget(self, action: #selector(textViewButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() { // 제약조건
        print("Add SetConstraints")
        super.setConstraints()
        
        
    }
    
    @objc func textViewButtonClicked() {
        let vc = TextViewController()
        
        vc.completionHandler = { value in
            self.mainView.textViewButton.setTitle(value, for: .normal)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func titleButtonClicked() {
        let vc = TitleViewController()
        // Closure - 3
        vc.completionHandler = { text, age, push in
            self.mainView.titleButton.setTitle(text, for: .normal)
            print("completionHandler", age, push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }

    @objc func dateButtonClicked() {
        // protocol 값 전달 5
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    

}

// protocol 값 전달 4
extension AddViewController: PassDataDelegate {
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
    
   
}

extension AddViewController: PassImageDelegate {
    func receiveImgData(img: UIImage) {
        print(img, #function)
        mainView.photoImageView.image = img
        
    }
}
