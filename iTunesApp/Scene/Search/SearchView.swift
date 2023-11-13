//
//  SearchView.swift
//  iTunesApp
//
//  Created by 김지연 on 11/11/23.
//

import UIKit
import SnapKit
import Kingfisher
import RxDataSources

class SearchView: UIView {
    
    
    let searchBar = UISearchBar()
    
    lazy var tableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = Constants.Color.background
        view.rowHeight = 90
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        
        return view
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<AppInfoModel> { dataSource, tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.appNameLabel.text = item.trackName
        cell.appNameLabel.text = item.trackName

        if let url = URL(string: item.artworkUrl512) {
            cell.appIconImage.kf.setImage(with: url)
        } else {
            DispatchQueue.main.async {
                cell.appIconImage.image = Constants.Image.noAppImage
            }
        }

        cell.installButton.setTitle("\(item.formattedPrice)", for: .normal)

        return cell
    }
    
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
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(5)
            
        }
    }
   
    
}


