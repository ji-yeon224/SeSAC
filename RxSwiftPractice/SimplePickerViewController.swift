//
//  SimplePickerViewController.swift
//  RxSwiftPractice
//
//  Created by 김지연 on 10/31/23.
//

import UIKit
import RxSwift
import RxCocoa

final class SimplePickerViewController: UIViewController {
    
//    @IBOutlet weak var pickerView1: UIPickerView!
//    @IBOutlet weak var pickerView2: UIPickerView!
//    @IBOutlet weak var pickerView3: UIPickerView!
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet var pickerView4: UIPickerView!
    
    @IBOutlet var label: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 1: \(models)")
            })
            .disposed(by: disposeBag)

        
        
        
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.green,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                          ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe(onNext: { models in
                print("models selected 2: \(models)")
                
            })
            .disposed(by: disposeBag)
        
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .bind { models in
                print("models selected 3: \(models)")
            }
            .disposed(by: disposeBag)
        setPickerView()
    }
    
    func setPickerView() {
        
        let items = Observable.just(["영화", "애니메이션", "드라마", "기타"])
        
        items
            .bind(to: pickerView4.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        
        pickerView4.rx.modelSelected(String.self)
            .map{ $0.description }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
}
