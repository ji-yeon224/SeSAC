//
//  BookCollectionViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookCollectionViewController: UICollectionViewController {
    
    var movieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    var color: [UIColor] = [.purple, .systemBrown, .orange, .darkGray, .blue, .systemRed, .systemIndigo, .systemTeal, .systemMint]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "책장"
        
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        setCollectionViewLayout()
        color.shuffle()
        
        
    }
    
    
    
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
        
    }
    
    
    func setCollectionViewLayout() {
        
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        
        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
        
    }

   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return BookCollectionViewCell()
        }
        
        let movie = movieInfo.movie[indexPath.row]
        cell.configCell(movie: movie)
        cell.backgroundColor = color[indexPath.row]
        cell.layer.cornerRadius = 20
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        
        movieInfo.movie[sender.tag].like.toggle()
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        
        vc.movieInfo = movieInfo.movie[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }

  

}
