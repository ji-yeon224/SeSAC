//
//  SettingViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/16.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    
    private let setting1 = [Setting(icon: "moon.fill", title: "방해 금지 모드"), Setting(icon: "bed.double.fill", title: "수면"), Setting(icon: "iphone", title: "업무"), Setting(icon: "person.fill", title: "개인 시간")]
    private let setting2 = [Setting(icon: nil, title: "모든 기기에서 공유")]
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Setting>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        navigationItem.title = "집중 모드"
        var snapshot = NSDiffableDataSourceSnapshot<Int, Setting>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(setting1, toSection: 0)
        snapshot.appendItems(setting2, toSection: 1)
        dataSource.apply(snapshot)
        
    }
    
    private func configure() {
        view.addSubview(collectionView)
        setConstraints()
        configureDataSource()
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    static private func collectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
        
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Setting> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            if let icon = itemIdentifier.icon {
                content.image = UIImage(systemName: icon)
                content.imageProperties.tintColor = .orange
                content.imageProperties.maximumSize = CGSize(width: 20, height: 20)
            }
            
            content.textProperties.font = .systemFont(ofSize: 13)
            
            
            
            cell.contentConfiguration = content
            cell.accessories = [ .disclosureIndicator() ]
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.cornerRadius = 10
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        
    }
   
    
}
