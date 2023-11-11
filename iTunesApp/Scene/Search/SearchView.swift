//
//  SearchView.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import SnapKit
import Kingfisher

class SearchView: UIView {
    
    //var dataSource: UICollectionViewDiffableDataSource<Int, AppInfo>!
    var dataSource: UITableViewDiffableDataSource<Int, AppInfo>!
    
    let searchBar = UISearchBar()
    
    lazy var tableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = Constants.Color.background
        view.rowHeight = 90
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.dataSource = dataSource
        
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setConstraints()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func config() {
        backgroundColor = Constants.Color.background
        addSubview(tableView)
        configureDataSource()
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(5)
            
        }
    }
   
    
    private func configureDataSource() {
        
        
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.appNameLabel.text = itemIdentifier.trackName
            
            if let url = URL(string: itemIdentifier.artworkUrl512) {
                cell.appIconImage.kf.setImage(with: url)
            } else {
                DispatchQueue.main.async {
                    cell.appIconImage.image = Constants.Image.noAppImage
                }
            }
            
            cell.installButton.setTitle("\(itemIdentifier.formattedPrice)", for: .normal)
            
            
            return cell
        })
        
        
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
//            //collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
//            return cell
//        })
    }
}


