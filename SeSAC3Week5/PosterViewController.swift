//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/16.
//

import UIKit

class PosterViewController: UIViewController {

    @IBOutlet var posterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        
        posterCollectionView.register(
            UINib(nibName: "PosterCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "PosterCollectionViewCell") //셀 등록
        posterCollectionView.register(
            UINib(nibName: "HeaderPosterCollectionReusableView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderPosterCollectionReusableView") //헤더 뷰 등록하기
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
        
    }
    
    


}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderPosterCollectionReusableView", for: indexPath) as? HeaderPosterCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.titleLabel.text = "테스트 섹션"
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    
}
