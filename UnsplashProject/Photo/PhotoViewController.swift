//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPhoto()
        
        viewModel.list.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.backgroundColor = .lightGray
        
        
        return cell
    }
    
}
