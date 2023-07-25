//
//  ResultViewController.swift
//  week2Assignment
//
//  Created by 김지연 on 2023/07/25.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet var emotionResultViews: [UIView]!
    @IBOutlet var emotionTitleLabel: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in emotionResultViews {
            view.layer.cornerRadius = 10
        }
        for label in emotionTitleLabel {
            label.textColor = .white
        }
        

    }

}
