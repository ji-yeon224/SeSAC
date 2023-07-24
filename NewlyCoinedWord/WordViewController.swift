//
//  WordViewController.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/20.
//

import UIKit

class WordViewController: UIViewController {
    

    let wordKeyList = ["자강두천", "분좋카", "내봬누", "완내스", "오저치고", "저메추"]
    let newWord: [String: String] = ["자강두천" : "자존심 강한 두 천재", "분좋카" : "분위기 좋은 카페", "내봬누" : "내일 봬요 누나", "완내스" : "완전 내 스타일", "오저치고" : "오늘 저녁 치킨 고?", "저메추" : "저녁 메뉴 추천"]
    

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
        if searchTextField.text == "" {
            showAlert("검색어를 입력하세요.")
            resultLabel.text = ""
        } else if newWord[searchTextField.text!] == nil {
            showAlert("검색 결과가 없습니다.")
            resultLabel.text = ""
        } else {
            resultLabel.text = newWord[searchTextField.text!]! + " 라는 뜻입니다."
        }
        
        
        
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
        
        var idx = 0
        for btn in wordListButtons {
            var config = UIButton.Configuration.plain()
            config.title = wordKeyList[idx]
            idx += 1
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
