//
//  BeerViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit
import SnapKit

class BeerViewController: UIViewController {
    
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, Beer>!
    var segmentedControl = UISegmentedControl(items: ["BeerList", "Ramdom Beer"])
    
    var beerList = BeerList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        configurationDataSource()
        segmentedControl.selectedSegmentIndex = 0
        callRequestBeer(router: .beers)
        updateSnapshot()
        collectionView.register(BeerCollectionViewCell.self, forCellWithReuseIdentifier: "beerCell")
        
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_: )), for: .valueChanged)
    }
    
    @objc private func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            callRequestBeer(router: .beers)
        case 1:
            callRequestBeer(router: .random)
        default:
            callRequestBeer(router: .beers)
        }
        
    }
    
    
    private func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
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
    
    

    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Beer>()
        snapshot.appendSections([0])
        snapshot.appendItems(beerList)
        dataSource.apply(snapshot)
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
        updateSnapshot()
        
    }
    
    

    
}

extension BeerViewController {

    func callRequestBeer(router: BeerRouter) {
        
        BeerNetwork.shared.requestBeerConvertible(type: BeerList.self, api: router) { response in
            switch response {
            case .success(let success):
                self.beerList = success
            case .failure(let failure):
                print(failure)
            }
            self.updateSnapshot()
        }
        
       
    }
}
