//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        
        //push - pop (nav)
        navigationController?.popViewController(animated: true)//한번에 돌아감
        
    }
    

}
