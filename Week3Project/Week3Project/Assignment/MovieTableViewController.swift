//
//  MovieTableViewController.swift
//  Week3Project
//
//  Created by 김지연 on 2023/07/30.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movieInfo = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        
        let movie = movieInfo.movie[indexPath.row]
        cell.configurationCell(row: movie)
        
        
        return cell
        
    }
   
}
