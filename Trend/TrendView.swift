//
//  TrendView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit
import SnapKit

class TrendView: BaseView {
    
//    let collectionView = {
//        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//
//        return view
//    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
    
    override func configureView() {
        //addSubview(label)
        
    }
    
    override func setConstraints() {
       
    }
    
    
}
