//
//  SampleViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/12.
//

import UIKit

struct User {
    let name: String
    let age: Int
    
    var introduce: String {
        return "\(name), \(age)살"
    }
}

class SampleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//        cell.textLabel?.text = data.introduce
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = "테스트" // textLabel
        content.secondaryText = "안녕하세요, \(indexPath.row)" // detailTextLabel
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}
