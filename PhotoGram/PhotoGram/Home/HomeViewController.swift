//
//  HomeViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/31.
//

import UIKit


protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainview = HomeView()
    
    override func loadView() {
        
        mainview.delegate = self
        self.view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        mainview.collectionView.delegate = self
        mainview.collectionView.dataSource = self
        
        APIService.shared.callRequest(query: "sky") { photo in
            guard let photo = photo else {
                print("ALERT ERROR")
                return
            }
            print("API END")
            self.list = photo
            self.mainview.collectionView.reloadData()
            
            
        }
    }
    
    deinit {
        print(self, #function)
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath)
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemBlue
        let thumb = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumb) //링크를 기반으로 이미지를 보여준다 -> 네트워크 통신
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        //delegate?.didSelectItemAt(indexPath: indexPath)
        
    }
}
