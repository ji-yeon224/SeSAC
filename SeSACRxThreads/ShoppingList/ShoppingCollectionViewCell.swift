//
//  ShoppingCollectionViewCell.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/4/23.
//

import UIKit
import SnapKit
import RxSwift

final class ShoppingCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShoppingCollectionViewCell"
    
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
        bind()
    }
   
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var checkState = false
    var starState = false
    
    lazy var check = BehaviorSubject(value: checkState)
    var checkImg = BehaviorSubject(value: Constants.Image.emptyCheck)
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
        
    }
    
    func bind() {
        
//        check
//            .bind(with: self) { owner, value in
//                let img = value ? Constants.Image.fillCheck : Constants.Image.emptyCheck
//                owner.checkImg.onNext(img)
//            }
//            .disposed(by: disposeBag)
        
        checkImg
            .bind(with: self) { owner, image in
                owner.checkButton.setImage(image, for: .normal)
            }
            .disposed(by: disposeBag)
        
//        checkButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.checkState.toggle()
//                let img = owner.checkState ? Constants.Image.fillCheck : Constants.Image.emptyCheck
//                owner.checkButton.setImage(img, for: .normal)
//            }
//            .disposed(by: disposeBag)
    }
    
    private func configure() {
        contentView.backgroundColor = .clear
        contentView.addSubview(backView)
        backView.addSubview(listLabel)
        backView.addSubview(checkButton)
        backView.addSubview(starButton)
        
    }
    
    private func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
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

