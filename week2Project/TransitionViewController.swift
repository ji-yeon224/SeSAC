//
//  TransitionViewController.swift
//  week2Project
//
//  Created by 김지연 on 2023/07/24.
//

import UIKit
import Kingfisher

class TransitionViewController: UIViewController {

    @IBOutlet var userTextField: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var actorImageView: UIImageView!
    
    let a = ["asd": "ASD", "sdf": "SDF"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        // 배열처럼 인덱스로 접근
        if sender.selectedSegmentIndex == 0 {
            let url = URL(string: "https://img.sbs.co.kr/newsnet/etv/upload/2023/06/13/30000854058_1280.jpg")
            actorImageView.kf.setImage(with: url)
            
        } else if sender.selectedSegmentIndex == 1 {
            let url = URL(string: "https://i.pinimg.com/474x/65/43/be/6543be87f87a07ebd8020689f38b081f.jpg")
            actorImageView.kf.setImage(with: url)
        } else {
            
        }
        
        
    }
    
    
    
    //다른 화면에서 TransitionViewController로 돌아올 때(unwind) 사용하는 기능
    //액션 연결 하지 않고, 직접 작성했습니다!
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        
    }
    

}
