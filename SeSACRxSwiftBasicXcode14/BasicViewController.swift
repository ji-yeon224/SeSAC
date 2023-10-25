//
//  BasicViewController.swift
//  SeSACRxSwiftBasicXcode14
//
//  Created by 김지연 on 2023/10/25.
//

import UIKit
import RxSwift
import RxCocoa

class BasicViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicTableView()
    }
    
    func basicTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        // 셀 클릭
        tableView.rx.modelSelected(String.self)
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        

    }
    
}



