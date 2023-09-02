//
//  TrendView.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit
import SnapKit

class TrendView: BaseView {
    
    var trendList: [ContentsData] = []
    var genreDictionary: [Int : String] = [:]
    
    weak var delegate: TrendViewProtocol?
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(TrendCollectionCell.self, forCellWithReuseIdentifier: TrendCollectionCell.identifier)
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size, height: size)
        return layout
    }
    
    
    override func configureView() {
        addSubview(collectionView)
        
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    
}


extension TrendView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionCell.identifier, for: indexPath) as? TrendCollectionCell else { return UICollectionViewCell() }


        let trendData = trendList[indexPath.row]


        if trendData.posterPath.count == 0 {
            cell.imageView.image = UIImage(systemName: "xmark")!
            cell.imageView.tintColor = .lightGray
        } else {
            let imageURL = TMDBApi.imgURL + trendData.posterPath
            let url = URL(string: imageURL)!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)

                }
            }
        }

        var genreString = ""
        for i in trendData.genreIDS {
            genreString += "#\(genreDictionary[i] ?? "") "

        }
        cell.genreLabel.text = genreString
        cell.titleLabel.text = trendData.title
        //cell.originalTitleLabel.text = trendData.originalTitle

        switch trendData.mediaType {
        case .tv:
            cell.titleLabel.text = trendData.name
            cell.releaseLabel.text = ""
        case .movie:
            cell.titleLabel.text = trendData.title
            cell.releaseLabel.text = trendData.releaseDate

        }



        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)

    }
}

