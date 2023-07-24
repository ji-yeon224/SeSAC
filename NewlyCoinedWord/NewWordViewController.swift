//
//  NewWordViewController.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/21.
//

import UIKit

class NewWordViewController: UIViewController {

    @IBOutlet var wordTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var wordFirstButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        wordFirstButton.titleLabel?.font = .systemFont(ofSize: 20)
//        wordFirstButton.titleLabel?.textColor = .black
        
        getRandomWord()
        //wordFirstButton.isHidden = true
        
        
    }
    
    @discardableResult
    func getRandomWord() -> String {
        let random = ["고래밥", "칙촉", "카스타드", "메로나", "월드콘"]
        let result = random.randomElement()!
        return result
    }
  
    @IBAction func wordButtonClicked(_ sender: UIButton) {
        print(sender.titleLabel?.text)
        wordTextField.text = sender.titleLabel?.text
        textFieldReturnKeyTapped(wordTextField)
    }
    //버튼 클릭 시 텍스트 필드에 버튼 타이틀이 들어감
    
    @IBAction func textFieldReturnKeyTapped(_ sender: UITextField) {
        
        print("Did End On Exit")
        
//
//        if wordTextField.text == "별다줄" {
//            resultLabel.text = "별다줄 뜻은 '별걸 다 줄인다' 입니다."
//        }else if wordTextField.text == "뉴진스"{
//            resultLabel.text = "뉴진스 뜻은 ..."
//        } else {
//            resultLabel.text = "검색 결과가 없습니다."
//        }
        
        switch wordTextField.text {
            case "별다줄": resultLabel.text = "별다줄 뜻은 '별걸 다 줄인다' 입니다."
            case "뉴진스": resultLabel.text = "뉴진스 뜻은 ..."
        case "jmt", "JMT": resultLabel.text = "맛있다"
                
            default: resultLabel.text = "검색 결과가 없습니다."
        }
        
        
    }
    

}
