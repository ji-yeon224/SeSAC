//
//  BeerViewController.swift
//  SeSAC3Week10
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit
import SnapKit

class BeerViewController: UIViewController {
    
    private var beer = Beer(id: 0, name: "'", imageURL: "")
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var dataSource: UICollectionViewDiffableDataSource<Int, Beer>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        configureDataSource()
        snapshot()
        getResponseBeerList()
        
    }
    
    func snapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Beer>()
        snapshot.appendSections([0])
        snapshot.appendItems([beer])
        dataSource.apply(snapshot)
    }
    
    func configure() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureDataSource() {
        
        let cellRigistration = UICollectionView.CellRegistration<UICollectionViewListCell, Beer> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            print(itemIdentifier.name)
//            DispatchQueue.global().async {
//                let url = URL(string: itemIdentifier.imageURL)!
//                let data = try? Data(contentsOf: url)
//
//                DispatchQueue.main.async {
//                    content.image = UIImage(data: data!)
//                    cell.contentConfiguration = content
//                }
//            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRigistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
        
        
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
        
    }

    
}

extension BeerViewController {
    func getResponseBeerList() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.beers) { response in
            switch response {
            case .success(let success):
                self.beer = success
                //dump(success)
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    func getResponseRandomBeer() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.random) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getResponseOneBeer() {
        BeerNetwork.shared.requestBeer(type: Beer.self, api: PunkAPI.single(id: 13)) { response in
            switch response {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
