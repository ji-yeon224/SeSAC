//
//  DetailViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contents: Contents?
    var creditList: [Credit] = []
    
    
    var trendData: ContentsData?
    var creditData = Credits(id: 0, cast: [], crew: [])
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var backDropImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var uiview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeaderAttribute()
        callCreditData()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = 100
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        
        
        let nib = UINib(nibName: DetailTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        let overviewNib = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        tableView.register(overviewNib, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(moveToRelatedView))
        
        
    }
    
    @objc func moveToRelatedView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: RelatedViewController.identifier) as! RelatedViewController
        
        guard let trendData else {
            return
        }
        
        vc.contentId = trendData.id
        vc.mediaType = trendData.mediaType.rawValue
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    
    func setHeaderAttribute() {
        guard let trendData else {
            dismiss(animated: true)
            return
        }
        
        setImage()
        
        title = "Detail Info"
        
        uiview.backgroundColor = .black
        uiview.layer.opacity = 0.5
        
        switch trendData.mediaType {
        case .movie: titleLabel.text = trendData.title
        case .tv: titleLabel.text = trendData.name
        }
        
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
        
        
        
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func setImage() {
        
        backDropImageView.contentMode = .scaleAspectFill
        backDropImageView.layer.backgroundColor = UIColor.black.cgColor
        backDropImageView.alpha = 0.8
        
        //poster
        let imageURL = TMDBApi.imgURL + trendData!.posterPath
        if let url = URL(string: imageURL){
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                    
                }
            }
        } else {
            posterImageView.backgroundColor = .lightGray
        }
        
        //backdrop
        let backdrop = TMDBApi.imgURL + trendData!.backdropPath
        if let url = URL(string: backdrop){
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.backDropImageView.image = UIImage(data: data)
                    
                    
                }
            }
        } else {
            backDropImageView.backgroundColor = .lightGray
        }
        
    }

    

}

extension DetailViewController {
    func getCreditData() {
        guard let trendData else {
            dismiss(animated: true)
            return
        }
        let parameter = "\(trendData.mediaType.rawValue)/\(trendData.id)/credits"
        TMDBApi.shared.callRequest(endPoint: .credit, parameter: parameter) { json in
            let data = json["cast"].arrayValue
            for i in 0...5 {
                self.creditList.append(Credit.init(name: data[i]["name"].stringValue,
                                                   profile: data[i]["profile_path"].stringValue,
                                                   character: data[i]["character"].stringValue))

            }

            self.tableView.reloadData()
        }


    }
    
    func callCreditData() {
        guard let trendData else {
            dismiss(animated: true)
            return
        }
        let parameter = "\(trendData.mediaType.rawValue)/\(trendData.id)/credits"
        TMDBApi.shared.callCreditRequest(endPoint: .credit, parameter: parameter) { credit in
            self.creditData = credit
            //print(self.creditData)
            self.tableView.reloadData()
        }
        
        
    }
    
    
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return section == 0 ? 1 : creditData.cast.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Overview" : "Cast"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        //overview
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as! OverviewTableViewCell
            cell.setOverviewCell()
            
            cell.overviewLabel.text = trendData?.overview
            
            return cell
            
        } else { //cast
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
            let credits = creditData.cast[indexPath.row]
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
        
        
        
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as! OverviewTableViewCell
//            //tableView.rowHeight = UITableView.automaticDimension
//            //cell.setChangeOverviewCell()
//            cell.buttonClicked(cell.moreButton)
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//
//        }
//    }


}
