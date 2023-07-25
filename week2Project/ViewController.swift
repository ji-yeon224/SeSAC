//
//  ViewController.swift
//  week2Project
//
//  Created by 김지연 on 2023/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    let list = ["가사1", "가사2", "가사3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.isUserInteractionEnabled = true
        
        print(firstImageView.isUserInteractionEnabled)
        print(view.isUserInteractionEnabled)
        
    }
    
    //다른 버튼인 것을 어떻게 구분? -> 태그기능
    @IBAction func playButtonClicked(_ sender: UIButton) {
        
        print(sender.tag)
        print(list[sender.tag - 1])
        
    }
    
    
    @IBAction func testTapGesture(_ sender: UITapGestureRecognizer) {
        print("first")
    }
    
    
    //레이블 텍스트가 길어서 보이지 않을 때 -> 탭 하여 이미지 뷰가 가려지고 레이블이 길게 보이게끔
    @IBAction func testSeconTapGesture(_ sender: UITapGestureRecognizer) {
        
        //1. -> 다시 이미지 보이지 않음..
        //firstImageView.isHidden = true
        
        print("제스쳐 전", firstImageView.isHidden)
        
        //2.
//        if firstImageView.isHidden == true {
//            firstImageView.isHidden = false
//        } else {
//            firstImageView.isHidden = true
//        }
        
        
        //3. not 연산자
        //firstImageView.isHidden = !firstImageView.isHidden
        
        //4. toggle -> 반대로 바꿔주는 기능
        //firstImageView.isHidden.toggle()
        
        
        
        //5. @@ ? ㅇㅇ : ㄴㄴ
        firstImageView.isHidden = firstImageView.isHidden == true ? false : true
        
        
        
        
        print("제스쳐 후", firstImageView.isHidden)
        
        
        
        
    }
    
}

