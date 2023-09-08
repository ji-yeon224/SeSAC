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
        view.register(DramaCollectionViewCell.self, forCellWithReuseIdentifier: DramaCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        view.prefetchDataSource = self
        
        return view
    }()
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width - 40
        layout.itemSize = CGSize(width: size, height: size * 1.5)
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


extension TrendView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let trendData = trendList[indexPath.row]
        
        switch trendData.mediaType {
        case .movie:
            guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionCell.identifier, for: indexPath) as? TrendCollectionCell else { return UICollectionViewCell() }
            


            if trendData.posterPath.count == 0 {
                movieCell.imageView.image = UIImage(systemName: "xmark")!
                movieCell.imageView.tintColor = .lightGray
            } else {
                let imageURL = TMDBApi.imgURL + trendData.posterPath
                let url = URL(string: imageURL)!
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        movieCell.imageView.image = UIImage(data: data)

                    }
                }
            }

            var genreString = ""
            for i in trendData.genreIDS {
                genreString += "#\(genreDictionary[i] ?? "") "

            }
            movieCell.genreLabel.text = genreString
            movieCell.titleLabel.text = trendData.title
            //cell.originalTitleLabel.text = trendData.originalTitle
            movieCell.titleLabel.text = trendData.title
            movieCell.releaseLabel.text = trendData.releaseDate
            return movieCell
            
        case .tv:
            guard let dramaCell = collectionView.dequeueReusableCell(withReuseIdentifier: DramaCollectionViewCell.identifier, for: indexPath) as? DramaCollectionViewCell else { return UICollectionViewCell() }
            


            if trendData.posterPath.count == 0 {
                dramaCell.imageView.image = UIImage(systemName: "xmark")!
                dramaCell.imageView.tintColor = .lightGray
            } else {
                let imageURL = TMDBApi.imgURL + trendData.posterPath
                let url = URL(string: imageURL)!
                DispatchQueue.global().async {
                    let data = try! Data(contentsOf: url)
                    DispatchQueue.main.async {
                        dramaCell.imageView.image = UIImage(data: data)

                    }
                }
            }

            var genreString = ""
            for i in trendData.genreIDS {
                genreString += "#\(genreDictionary[i] ?? "") "

            }
            dramaCell.genreLabel.text = genreString
            dramaCell.titleLabel.text = trendData.title
            dramaCell.titleLabel.text = trendData.name
            return dramaCell
        }
     


    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let cell = collectionView.cellForItem(at: indexPath) as? TrendCollectionCell else { return }
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
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}

