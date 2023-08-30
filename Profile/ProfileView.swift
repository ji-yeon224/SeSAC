//
//  ProfileView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let tableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        view.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        return view
    }()
    
    override func configureView() {
        addSubview(tableView)
        tableView.rowHeight = 50
        
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
