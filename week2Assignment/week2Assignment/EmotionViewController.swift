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
    var emotionCount = [Int](repeating: 0, count: 5)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func EmotionButtonClicked(_ sender: UIButton) {
        
        emotionCount[sender.tag] += 1
        let emotion = Emotion(rawValue: sender.tag)
        print(emotion!, emotionCount[sender.tag])
        
        let value = UserDefaults.standard.integer(forKey: emotion!.mood)
        let result = value + 1
        UserDefaults.standard.set(result, forKey: emotion!.mood)
        
        
    }
  


}
