//
//  SearchViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import RealmSwift


class SearchViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 200
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = "도서를 검색하세요."
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonClicked)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        //callRequest()
        
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func callRequest(keyword: String, page: Int){
        
        let query = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=15&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.isEnd = json["Meta"]["is_end"].boolValue
                
                let searchList = json["documents"]
                for book in searchList.arrayValue {
                    var authorList = ""
                    for aut in book["authors"].arrayValue {
                        authorList += aut.stringValue
                    }
                    
                    let title = book["title"].stringValue
                    let poster = book["thumbnail"].stringValue
                    let contents =  book["contents"].stringValue
                    let datetime = book["datetime"].stringValue
                    let publisher = book["publisher"].stringValue
                    let price = book["sale_price"].intValue
                    self.bookList.append(Book(title: title, author: authorList, poster: poster, contents: contents, datetime: datetime, publisher: publisher, price: price))
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    

  
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        
       
        cell.authorLabel.text = bookList[indexPath.row].author
        cell.bookImageView.kf.setImage(with: URL(string: bookList[indexPath.row].poster))
        cell.titleLabel.text = bookList[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: BookDetailViewController.identifier) as! BookDetailViewController
        
        let selectedBook = bookList[indexPath.row]
        
        let task = BookTable(title: selectedBook.title, author: selectedBook.author, poster: selectedBook.poster, contents: selectedBook.contents, publisher: selectedBook.publisher, price: selectedBook.price)
        
        
        vc.book = task
        vc.viewTransition = .search
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page <= 50 && !isEnd{
                page += 1
                callRequest(keyword: searchBar.text!, page: page)
            }
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            bookList.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print(searchBar.text)
        
        guard let keyword = searchBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        bookList.removeAll()
        page = 1
        callRequest(keyword: keyword, page: page)
        tableView.reloadData()
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        bookList.removeAll()
        tableView.reloadData()
        view.endEditing(true)
        
    }
    
    
    
}
