//
//  TrendCollectionViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit

class TrendCollectionViewController: BaseViewController {
    
    let mainView = TrendView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        
    }
    
}

extension TrendCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionCell.identifier, for: indexPath) as? TrendCollectionCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
}
