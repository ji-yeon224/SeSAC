//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

enum TransitionType: String {
    case add = "추가화면"
    case edit = "수정화면"
}

class AddViewController: UIViewController, UITextViewDelegate {
    
    static let identifier = "AddViewController"
    
    @IBOutlet var textView: UITextView!
    
    var type: TransitionType = .add
    var contents: String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        setBackgroundColor()
        textView.isEditable = true
        textView.text = contents
        title = type.rawValue
        
        switch type {
        case .add:
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "xmark"),
                style: .plain,
                target: self,
                action: #selector(closeButtonClicked)
            )
            navigationItem.leftBarButtonItem?.tintColor = .yellow
            
            
        case .edit: print("")
            
        }
        
    }
    
    
    //텍스트가 변경될 때 마다 -> 글자 수 체크 등
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)글자"
        
    }
    
    
    @objc
    func closeButtonClicked() {
        
        //present - dismiss / push - pop 으로 화면 전환 코드의 짝을 맞춰야 한다.
        dismiss(animated: true) //화면이 사라지는 코드
        
        
    }


}

