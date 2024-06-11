//
//  RxTableViewController.swift
//  RxSwiftPractice
//
//  Created by 김지연 on 10/31/23.
//

import UIKit
import RxSwift

class RxTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        
    }
    
    func setTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just(["First Item", "Second Item", "Third Item"])
        
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @row \(row)"
            return cell
            
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map{
                "\($0)를 클릭했습니다."
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}

