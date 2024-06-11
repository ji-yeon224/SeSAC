//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"



class SearchCollectionViewController: UICollectionViewController {
    
    
    static let identifier = "SearchCollectionViewController"
    
    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사자", "사과", "호랑이"]
    var searchList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        
        //XIB 연결
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")

        setCollectionViewLayout()
      
    }
    
    func setCollectionViewLayout() {
        
        //cell estimated size none으로 인터페이스 빌더에서 설정할 것!
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout //레이아웃 교체하려는 것으로 바꾸기
        
    }
    
    //1. 셀 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    //2.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return SearchCollectionViewCell()
        }
        
        cell.backgroundColor = .brown
        cell.contentsLabel.text = searchList[indexPath.row]
        
        return cell
        
    }
    
    
}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    
    
    
    //리턴키
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        searchBar.text = ""
        collectionView.reloadData()
        
    }
    
    //취소버튼 액션 구현
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList.removeAll()
        collectionView.reloadData()
    }
    
    //글자가 바뀔 때 마다 호출 -> 실시간 검색 기능의 핵심 부분
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        collectionView.reloadData()
        
    }
    
    
}
    
