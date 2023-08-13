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

        print(contents)
    }
    

}
