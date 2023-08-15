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
    
    @IBOutlet var infoView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var overviewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHeaderInfo()
        getCreditData()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: DetailTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        
    }
    
    
    
    func setHeaderInfo() {
        guard let contents else {
            dismiss(animated: true)
            return
        }
        let imageURL = TMDBApi.imgURL + contents.poster
        if let url = URL(string: imageURL){
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                    
                }
            }
        } else {
            posterImageView.image = UIImage(systemName: "xmark")
            posterImageView.tintColor = .lightGray
        }
       
        infoView.layer.opacity = 80
        infoView.layer.backgroundColor = UIColor.systemGray6.cgColor
        
        title = contents.title
        overviewText.isEditable = false
        titleLabel.text = contents.title
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        releaseLabel.text = contents.release
        releaseLabel.font = .systemFont(ofSize: 13)
        overviewText.text = contents.overview
        overviewText.font = .systemFont(ofSize: 15)
        overviewText.layer.backgroundColor = UIColor.clear.cgColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }

    

}

extension DetailViewController {
    func getCreditData() {
        guard let contents else {
            dismiss(animated: true)
            return
        }
        let parameter = "\(contents.media_type)/\(contents.id)/credits"
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
    
    
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        
        cell.characterLabel.text = creditList[indexPath.row].character
        cell.nameLabel.text = creditList[indexPath.row].name
        
        let imageURL = TMDBApi.imgURL + creditList[indexPath.row].profile
        if let url = URL(string: imageURL) {
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.profileImageView.image = UIImage(data: data)
                    
                }
            }
        } else {
            cell.profileImageView.image = UIImage(systemName: "person")
            cell.profileImageView.tintColor = .lightGray
        }
        
        
        return cell
    }


}
