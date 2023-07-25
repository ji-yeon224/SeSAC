//
//  EmotionViewController.swift
//  week2Assignment
//
//  Created by 김지연 on 2023/07/25.
//

import UIKit

class EmotionViewController: UIViewController {

    
    @IBOutlet var EmotionButtons: [UIButton]!
    let emotionList = Emotion.allCases
    var emotionCount = [0, 0, 0, 0, 0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func EmotionButtonClicked(_ sender: UIButton) {
        
        emotionCount[sender.tag] += 1
        print(emotionList[sender.tag], emotionCount[sender.tag])
    }
  


}
