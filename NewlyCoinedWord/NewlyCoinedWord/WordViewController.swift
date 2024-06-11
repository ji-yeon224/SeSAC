//
//  WordViewController.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/20.
//

import UIKit

class WordViewController: UIViewController {
    
    
    
    let wordList = NewWord.allCases
    

//    let wordKeyList = ["자강두천", "분좋카", "내봬누", "완내스", "오저치고", "저메추"]
//    let newWord: [String: String] = ["자강두천" : "자존심 강한 두 천재", "분좋카" : "분위기 좋은 카페", "내봬누" : "내일 봬요 누나", "완내스" : "완전 내 스타일", "오저치고" : "오늘 저녁 치킨 고?", "저메추" : "저녁 메뉴 추천"]
//

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
   
    
    @IBOutlet var wordListButtons: [UIButton]!
    
    @IBOutlet var resultImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designProperties()
        
        

        
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        searchButtonClicked(searchButton)
    }
    @IBAction func listSearchButton(_ sender: UIButton) {
        searchTextField.text = sender.titleLabel?.text
        
        searchButtonClicked(sender)
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        
        view.endEditing(true)
        
        print(searchTextField.state.isEmpty)
        
        //입력된 텍스트의 값이 nil
            guard let _ = searchTextField.text else {
            showAlert("검색어를 입력하세요.")
            resultLabel.text = ""
            return
        }
        
        
        
        let result: String?
        switch searchTextField.text {
            
        case "별다줄": result = NewWord.별다줄.rawValue
        case "자강두천": result = NewWord.자강두천.rawValue
        case "분좋카": result = NewWord.분좋카.rawValue
        case "내봬누": result = NewWord.내봬누.rawValue
        case "완내스": result = NewWord.완내스.rawValue
        case "오저치고": result = NewWord.오저치고.rawValue
        case "저메추": result = NewWord.저메추.rawValue
        default: result = nil
        }
        
        guard let _ = result else {
            showAlert("검색 결과가 없습니다.")
            resultLabel.text = ""
            return
        }
        
        resultLabel.text = result! + " 라는 뜻입니다."
        
      
    }
    
    @IBAction func tapTextField(_ sender: UITextField) {
        
        searchTextField.text = nil
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
    func designProperties() {
        
        searchButton.tintColor = .white
        searchTextField.layer.borderWidth = 2
        searchTextField.layer.borderColor = UIColor.black.cgColor
        
        
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 18)
        resultLabel.text = ""
        
        let wordBtn = wordList.shuffled()
        for btn in wordListButtons {
            var config = UIButton.Configuration.plain()
            let word = wordBtn[btn.tag] //NewWord(rawValue: btn.tag)
            config.title = word.wordString
            config.cornerStyle = .capsule
            
            
            btn.configuration = config
            btn.tintColor = .black
            btn.layer.borderColor = UIColor.black.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 15
        }
        
        resultImageView.image = UIImage(named: "background")
        resultImageView.contentMode = .scaleToFill
        
        
    }
    

   

}
