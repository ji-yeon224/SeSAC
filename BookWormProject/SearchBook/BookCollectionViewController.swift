//
//  BookCollectionViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit
import RealmSwift


class BookCollectionViewController: UICollectionViewController {
    
    var movieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tasks: Results<BookTable>!
    
    let realm = try! Realm()
    
    var color: [UIColor] = [.purple, .systemBrown, .orange, .darkGray, .blue, .systemRed, .systemIndigo, .systemTeal, .systemMint]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Book"
        
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        setCollectionViewLayout()
        color.shuffle()
        
        
        tasks = realm.objects(BookTable.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print(#function)
       
        
        print(#function)
        collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
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
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        
        layout.itemSize = CGSize(width: width / 3, height: width / 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        
        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
        
    }

   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return BookCollectionViewCell()
        }
        
       
        cell.configCell(book: tasks[indexPath.row])
        return cell
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: BookDetailViewController.identifier) as! BookDetailViewController
        let selectItem = tasks[indexPath.row]
        
        vc.book = selectItem
        vc.viewTransition = .main
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
        
    }

  

}
