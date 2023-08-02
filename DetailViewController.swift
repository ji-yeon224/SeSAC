//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    //Pass Data 1. 데이터를 받을 공간(프로퍼티 생성)
    var contents: String = "빈 공간"
    
    @IBOutlet var contentsLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        contentsLabel.numberOfLines = 0
        
        print(contents)
        //Pass Data 3. 전달 받은 값을 뷰에 표현
        contentsLabel.text = contents
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        
        //push - pop (nav)
        navigationController?.popViewController(animated: true)//한번에 돌아감
        
    }
    

}
