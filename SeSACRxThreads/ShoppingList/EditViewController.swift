//
//  EditViewController.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/5/23.
//

import UIKit
import RxSwift
import RxCocoa

final class EditViewController: UIViewController {
    
    var data: (Int, String)?
    var todo: TodoList?
    var editHandler: ((EditType, String?) -> Void)?
    
    let updateButtonEnabled = BehaviorSubject(value: true)
    let updateButtonColor = BehaviorSubject(value: Constants.Color.cellColor)
    let disposeBag = DisposeBag()
    
    let mainView = EditView()
    
    override func loadView() {
        self.view = mainView
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        bind()
    }
    
    func configure() {
        guard let todo = todo else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        mainView.updateTextField.text = todo.title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.Image.back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
    }
    
    func bind() {
        
        updateButtonEnabled
            .bind(to: mainView.updateButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        updateButtonEnabled
            .bind(with: self) { owner, value in
                let color = value ? Constants.Color.cellColor : Constants.Color.lightGray
                owner.updateButtonColor.onNext(color)
            }
            .disposed(by: disposeBag)
        
        updateButtonColor
            .bind(to: mainView.updateButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.updateTextField.rx.text.orEmpty
            .map{ $0.count > 0 }
            .bind(to: updateButtonEnabled)
            .disposed(by: disposeBag)
        
        mainView.updateButton.rx.tap
            .withLatestFrom(mainView.updateTextField.rx.text.orEmpty) { _, text in
                return text
            }
            .bind(with: self) { owner, value in
                if !value.trimmingCharacters(in: .whitespaces).isEmpty {
                    guard let todo = owner.todo else {
                        owner.navigationController?.popViewController(animated: true)
                        return
                    }
                    
                    owner.editHandler?(.update, value)
                    owner.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        
    }
    
    @objc private func deleteButtonTapped() {
        
        guard let todo = todo else {
            navigationController?.popViewController(animated: true)
            return
        }
        editHandler?(.delete, nil)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc private func backButtonTapped() {
        guard let todo = todo else {
            navigationController?.popViewController(animated: true)
            return
        }
        editHandler?(.none, nil)
        navigationController?.popViewController(animated: true)
        
    }
    
}
