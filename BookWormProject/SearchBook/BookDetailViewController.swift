//
//  BookDetailViewController.swift
//  BookWormProject
//
//  Created by 김지연 on 2023/08/09.
//

import UIKit
import RealmSwift

class BookDetailViewController: UIViewController {
    
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var book: BookTable?
    var bookId: ObjectId?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        book = realm.object(ofType: BookTable.self, forPrimaryKey: bookId)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setProperties()
        setValues()
        
        
        
        
    }
    
    func setValues() {
        if let book {
            print(book)
            bookTitleLabel.text = book.title
            bookInfoLabel.text = "\(book.author) | \(book.publisher)"
            let url = URL(string: book.poster)!
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }

            }
            saveImageToDocument(fileName: "book_\(book._id).jpg", image: book.poster)
            posterImageView.image = loadImageFromDocument(fileName: "book_\(book._id).jpg")
            contentsLabel.text = book.contents
            priceLabel.text = "\(book.price)원"
            

            
            
            
        }
    }
    
    
    
    
    func setProperties() {
        
        guard let book = book else {
            return
        }
        
        backView.backgroundColor = .systemGray6
        
        bookTitleLabel.font = .boldSystemFont(ofSize: 15)
        posterImageView.contentMode = .scaleAspectFill
        
        bookInfoLabel.font = .systemFont(ofSize: 13)
        bookInfoLabel.numberOfLines = 0
        priceLabel.font = .systemFont(ofSize: 13)
        contentsLabel.numberOfLines = 0
        contentsLabel.font = .systemFont(ofSize: 14)
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissButton))
        title = book.title
    }
    
    @objc func dismissButton() {
        dismiss(animated: true)
    }
    


}
