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
        //print(contents)
        getCreditData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: DetailTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        
    }
    
    func getCreditData() {
        TMDBApi.shared.creditCallRequest(genre: "movie", id: contents!.id) { json in
            let data = json["cast"].arrayValue
            for i in 0...5 {
                self.creditList.append(Credit.init(name: data[i]["name"].stringValue,
                                                   profile: data[i]["profile_path"].stringValue,
                                                   character: data[i]["character"].stringValue))
                //print(self.creditList)
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    func setHeaderInfo() {
        let url = URL(string: "https://image.tmdb.org/t/p/original" + contents!.poster)!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
                
            }
        }
        titleLabel.text = contents!.title
        releaseLabel.text = contents!.release
        overviewText.text = contents!.overview
        
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
        
        
        let url = URL(string: "https://image.tmdb.org/t/p/original"+creditList[indexPath.row].profile)!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.profileImageView.image = UIImage(data: data)
                
            }
        }
        
        return cell
    }


}
