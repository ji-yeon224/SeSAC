//
//  BeerView.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/22.
//

import UIKit

class BeerView: UIView {
    
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, Beer>!
    var segmentedControl = UISegmentedControl(items: ["BeerList", "Ramdom Beer"])
    
    var beerList = BeerList()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
        setConstraints()
        configurationDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfiguration() {
        addSubview(segmentedControl)
        addSubview(collectionView)
        
        collectionView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: "beerCell")
    }
    
    private func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    
    private func configurationDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BeerCollectionViewCell, Beer> { cell, indexPath, itemIdentifier in
            
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.label.text = itemIdentifier.name
            
            
            DispatchQueue.global().async {
                guard let url = itemIdentifier.imageURL else {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(systemName: "wineglass")
                    }
                    return
                }
                
                guard let imgURL = URL(string: url) else {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(systemName: "wineglass")
                    }
                    return
                }
                let data = try? Data(contentsOf: imgURL)

                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                    
                }
            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    

    
    
}
