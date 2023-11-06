//
//  RankView.swift
//  BoxOffice
//
//  Created by 김지연 on 11/6/23.
//

import UIKit

final class RankView: BaseView {
    
    lazy var dateTextField = {
        let view = UITextField()
        view.inputView = datePickerView
        view.backgroundColor = .secondarySystemBackground
        view.textColor = .darkGray
        view.layer.cornerRadius = 10
        view.text = DateFormatter.convertDate(date: Date())
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 13.0, height: 0.0))
        view.leftViewMode = .always
        view.tintColor = .clear
        view.delegate = self
        return view
    }()
    
    let datePickerView = {
        let view = UIDatePicker()
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        view.locale = Locale(identifier: "ko-KR")
        view.maximumDate = Date()
        
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout())
        view.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
        view.backgroundColor = .white
        return view
    }()
    
    override func configure() {
        super.configure()
        [dateTextField, collectionView].forEach {
            addSubview($0)
        }
        setupToolBar()
    }
    
    override func setConstraints() {
        
        dateTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
    }
    
    
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size, height: 80)
        return layout
    }
    
    private func setupToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: 0, height: 40)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))

        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        
        dateTextField.resignFirstResponder()
    }
}

extension RankView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
}
