//
//  DetailView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/04.
//

import UIKit

class DetailView: BaseView {
    
    var delegate: DetailViewProtocol?
    var isExpand = false
    
    lazy var tableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.register(CastCell.self, forCellReuseIdentifier: CastCell.identifier)
        view.register(OverviewCell.self, forCellReuseIdentifier: OverviewCell.identifier)
        
        return view
    }()
    
    override func configureView() {
        addSubview(tableView)
       
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}



extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Overview" : "Cast"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { //overview
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.identifier) as? OverviewCell else { return UITableViewCell() }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setOverViewCell(isExpand: isExpand)
            cell.overviewLabel.numberOfLines = isExpand ? 0 : 2
            
            return cell
        } else {//cast
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.identifier) as? CastCell else { return UITableViewCell() }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isExpand.toggle()
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
