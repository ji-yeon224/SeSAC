//
//  ViewController.swift
//  week2Project
//
//  Created by 김지연 on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.isUserInteractionEnabled = true
        
        print(firstImageView.isUserInteractionEnabled)
        print(view.isUserInteractionEnabled)
        
    }
    @IBAction func testTapGesture(_ sender: UITapGestureRecognizer) {
        print("first")
    }
    
    @IBAction func testSeconTapGesture(_ sender: UITapGestureRecognizer) {
        print("second")
    }
    
}

