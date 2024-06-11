//
//  LEDBoardViewController.swift
//  NewlyCoinedWord
//
//  Created by 김지연 on 2023/07/24.
//

import UIKit

class LEDBoardViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var randomColorButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var upSideView: UIView!
    let colorList: [UIColor] = [.black, .cyan, .orange, .green, .systemOrange, .systemPink, .systemYellow, .systemIndigo]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.layer.borderColor = UIColor.brown.cgColor
        textField.layer.borderWidth = 3
        
        resultLabel.font = .boldSystemFont(ofSize: 100)
        resultLabel.textAlignment = .center
        resultLabel.textColor = colorList.randomElement()!
        resultLabel.numberOfLines = 2
        
        sendButton.layer.borderWidth = 2
        sendButton.layer.cornerRadius = 10
        sendButton.layer.borderColor = UIColor.brown.cgColor
        sendButton.tintColor = .black
        
        randomColorButton.layer.borderWidth = 2
        randomColorButton.layer.cornerRadius = 10
        randomColorButton.layer.borderColor = UIColor.brown.cgColor
        randomColorButton.tintColor = .orange
        
        
        
    }
    
    @IBAction func returnKeyTapped(_ sender: UITextField) {
        
        sendButtonTapped(sendButton)
        
    }
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        upSideView.isHidden.toggle()
    }
    
    @IBAction func randomColorButtonTapped(_ sender: UIButton) {
        resultLabel.textColor = colorList.randomElement()!
        
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        resultLabel.text = textField.text
        
        
    }
    

}
