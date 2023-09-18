//
//  NewSimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/14.
//

import UIKit
import SnapKit

class NewSimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 200
        case second = 1
    }
    
    let viewModel = NewSimpleViewModel()
    
    
    
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource()
        
        viewModel.list.bind { user in
            self.updateSnapshot()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
            self.updateSnapshot()
        }
        
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        snapshot.appendSections(["고래밥", "jack"])
        snapshot.appendItems(viewModel.list.value, toSection: "고래밥")
        snapshot.appendItems(viewModel.list2, toSection: "jack")
        dataSource.apply(snapshot)
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false // 셀 경계선
        configuration.backgroundColor = .systemTeal
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureDataSource() {
        
        // UICollectionView.CellRegistration iOS 14, 메서드 대신 제네릭 사용, 셀이 생성될 때 마다 클로저가 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User> { cell, indexPath, itemIdentifier in
            
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
        
        //CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        
    }
    
}

extension NewSimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let user = viewModel.list.value[indexPath.item]
        
        guard let user = dataSource.itemIdentifier(for: indexPath)
        else {
            return
        }
        dump(user)
        
    }
}

extension NewSimpleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!)
    }
    
}



//extension NewSimpleCollectionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        return cell
//    }
//
//}
