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
    
    var creditList: [Credit] = []
    var trendData: ContentsData?
    var creditData = Credits(id: 0, cast: [], crew: [])
    
    lazy var tableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.register(CastCell.self, forCellReuseIdentifier: CastCell.identifier)
        view.register(OverviewCell.self, forCellReuseIdentifier: OverviewCell.identifier)
        view.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailHeaderView.identifier)
        return view
    }()
    
    override func configureView() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}



extension DetailView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 1
        } else {
            return creditData.cast.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "OverView"
        } else if section == 2 {
            return "Cast"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 { //overview
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewCell.identifier) as? OverviewCell else { return UITableViewCell() }
            guard let trendData else { return cell }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.setOverViewCell(isExpand: isExpand)
            cell.overviewLabel.text = trendData.overview
            cell.overviewLabel.numberOfLines = isExpand ? 0 : 2
            
            return cell
            
        } else if indexPath.section == 2 { //cast
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.identifier) as? CastCell else { return UITableViewCell() }
            
            let credits = creditData.cast[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.characterLabel.text = credits.character
            cell.nameLabel.text = credits.name
            
            if credits.profilePath == nil {
                cell.profileImageView.image = UIImage(systemName: "person")
                cell.profileImageView.tintColor = .lightGray
            } else {
                let imageURL = TMDBApi.imgURL + credits.profilePath!
                let url = URL(string: imageURL)
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        cell.profileImageView.image = UIImage(data: data)
                        
                    }
                }
                
            }
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            isExpand.toggle()
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        delegate?.didSelectRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 230 : 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailHeaderView.identifier) as? DetailHeaderView
            return header
        }
        
        return nil
        
        
    }
}
