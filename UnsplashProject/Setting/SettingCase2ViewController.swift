//
//  SettingCase2ViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/16.
//

import UIKit
import SnapKit

class SettingCase2ViewController: UIViewController {
    
    
    var allSetting = ["공지사항", "실험실", "버전 정보"]
    var personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var otherSetting = ["고객센터/도움말"]
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        configureDataSource()
        
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems(allSetting, toSection: 0)
        snapshot.appendItems(personalSetting, toSection: 1)
        snapshot.appendItems(otherSetting, toSection: 2)
        dataSource.apply(snapshot)
    }
    
    private func configure() {
        view.addSubview(collectionView)
        navigationItem.title = "설정"
        
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private static func configureLayout() -> UICollectionViewLayout{
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, String> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.font = .systemFont(ofSize: 13)
            cell.contentConfiguration = content
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    
    
}
