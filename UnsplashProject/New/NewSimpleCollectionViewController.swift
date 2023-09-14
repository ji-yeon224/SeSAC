//
//  NewSimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/14.
//

import UIKit
import SnapKit

class NewSimpleCollectionViewController: UIViewController {
    
    var list = [ User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "kokojong", age: 20) ]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // UICollectionView.CellRegistration iOS 14, 메서드 대신 제네릭 사용, 셀이 생성될 때 마다 클로저가 호출
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            // 셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            
            content.textProperties.color = .brown
            content.imageProperties.tintColor = .orange
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPurple
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
       
        
    }
    
    static func createLayout() -> UICollectionViewLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false // 셀 경계선
        configuration.backgroundColor = .systemTeal
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
    }
    
}
