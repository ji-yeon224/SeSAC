//
//  ShoppingView.swift
//  SeSACRxThreadsAssignment
//
//  Created by 김지연 on 11/4/23.
//

import UIKit
import SnapKit

final class ShoppingView: UIView {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        view.backgroundColor = .white
        
        return view
    }()
    
    let backView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.cellColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let addTextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하시겠어요?"
        return view
    }()
    
    let addButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.backgroundColor = Constants.Color.buttonColor
        view.tintColor = .black
        view.layer.cornerRadius = 5
        return view
    }()
    
    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(backView)
        addSubview(collectionView)
        addSubview(searchBar)
        backView.addSubview(addTextField)
        backView.addSubview(addButton)
        
        
    }
    
    private func setConstraints() {
        backView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(18)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.trailing.equalTo(backView).offset(-10)
            make.height.equalTo(backView.snp.height).multipliedBy(0.6)
            make.width.equalTo(addButton.snp.height)
        }
        
        addTextField.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.leading.equalTo(backView.snp.leading).offset(15)
            make.trailing.equalTo(addButton.snp.leading).offset(15)
            make.height.equalTo(backView.snp.height).multipliedBy(0.7)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size, height: 60)
        return layout
    }
    
}
