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
        //basicButton()
        basicValidation()
        shareButton()
    }
    
    func shareButton() {
        
        let sample = button.rx.tap
            .map { "안녕하세요 \(Int.random(in: 1...100))" }
            .share()
        
        
        
        sample
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        sample
            .bind(to: textField.rx.text)
            .disposed(by: disposeBag)
        
        sample
            .bind(to: button.rx.title())
            .disposed(by: disposeBag)
        
    }
    
    func basicValidation() {
        
        textField.rx.text.orEmpty
            .map{ $0.count > 4 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    func basicButton() {
        button.rx.tap // touchUpInside
            .observe(on: MainScheduler.instance) // 메인 스레드에서 동작하게끔 수정
            .subscribe { _ in // next, complete, error 다 전달 가능
                print("클릭되었습니다.")
                self.label.text = "클릭되었습니다."
                self.textField.text = "클릭되었습니다"
            } onDisposed: {
                print("Disposed")
            }
        
        button.rx.tap
            .bind { _ in // next만 가능. 메인 스레드에서 동작하는 것을 보장(보라색 에러 안남!)
                print("클릭되었습니다.")
                self.label.text = "클릭되었습니다."
                self.textField.text = "클릭되었습니다"
            }
            .disposed(by: disposeBag)
        
        button
            .rx
            .tap
            .map{ "클릭되었습니다." }
            .bind(to: label.rx.text, textField.rx.text)
            .disposed(by: disposeBag)

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
        tableView
            .rx
            .modelSelected(String.self)
            .map{ data in
                "\(data)를 클릭했어요."
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        

    }
    
}



