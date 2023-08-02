//
//  AroundViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/08/02.
//

import UIKit

class AroundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
 
    var movieInfo = MovieInfo()
   
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var posterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        let tableViewNib = UINib(nibName: "MovieInfoTableViewCell", bundle: nil)
        movieTableView.register(tableViewNib, forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        
        movieTableView.rowHeight = 100
        
        posterCollectionView.dataSource = self
        posterCollectionView.delegate = self
        
        let collectionViewNib = UINib(nibName: "PosterCollectionViewCell", bundle: nil)
        posterCollectionView.register(collectionViewNib, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionViewLayout()
        
        
        
        
        
    }
    
    //테이블 뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = movieTableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier) as! MovieInfoTableViewCell
        let movie = movieInfo.movie[indexPath.row]
        cell.configurationCell(movie: movie)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        let movie = movieInfo.movie[indexPath.row]
        vc.movieInfo = movie
        vc.transitionState = "present"
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    

    
    
    
    
    
    //컬렉션 뷰
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = posterCollectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        
        cell.configurePosterImage(movieTitle: movieInfo.movie[indexPath.row].title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        let movie = movieInfo.movie[indexPath.row]
        vc.movieInfo = movie
        vc.transitionState = "present"
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        posterCollectionView.collectionViewLayout = layout
    }


}
