//
//  ShoppingTableViewCell.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/10/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingTableViewCell: UITableViewCell {
    static let identifier = "ShoppingTableViewCell"
    
    private let backView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.cellColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    var listLabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()
    
    var checkButton = {
        let view = UIButton()
        view.setImage(Constants.Image.emptyCheck, for: .normal)
        view.tintColor = .black
        view.backgroundColor = .clear
        return view
    }()
    
    var starButton = {
        let view = UIButton()
        view.setImage(Constants.Image.emptyStar, for: .normal)
        view.tintColor = .black
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//        setConstraints()
//        //bind()
//    }
   
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var checkImg = BehaviorSubject(value: Constants.Image.emptyCheck)
    var checkValue = BehaviorSubject(value: false)
    
    var starImg = BehaviorSubject(value: Constants.Image.emptyStar)
    var starValue = BehaviorSubject(value: false)
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    
    
    private func configure() {
        contentView.backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(listLabel)
        backView.addSubview(checkButton)
        backView.addSubview(starButton)
        selectionStyle = .none
    }
    
    private func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.leading.equalTo(backView.snp.leading).offset(10)
            make.height.equalTo(backView.snp.height).multipliedBy(0.8)
            make.width.equalTo(checkButton.snp.height)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.trailing.equalTo(backView.snp.trailing).offset(-10)
            make.height.equalTo(backView.snp.height).multipliedBy(0.8)
            make.width.equalTo(starButton.snp.height)
        }
        
        listLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.trailing.equalTo(starButton.snp.leading).offset(12)
            make.height.equalTo(backView.snp.height).multipliedBy(0.8)
        }
    }
    
}

