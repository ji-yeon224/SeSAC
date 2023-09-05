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
    @IBOutlet var memoTextView: UITextView!
    
    var book: BookTable?
    var bookId: ObjectId?
    let realm = try! Realm()
    let placeholder = "메모를 입력하세요."
    var viewTransition: ViewTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //book = realm.object(ofType: BookTable.self, forPrimaryKey: bookId)
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        setProperties()
        setValues()
        configBarButtonItem()
        
    }
    
    func configBarButtonItem() {
        var buttons: [UIBarButtonItem]?
        
        switch viewTransition {
        case .main:
            let delete = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteButtonClicked))
            let update = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(updateButtonClicked))
            delete.tintColor = .black
            update.tintColor = .black
            buttons = [delete, update]
        case .search:
            let save = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(saveButtonClicked))
            save.tintColor = .black
            buttons = [save]
        default: print("")
        }
        navigationItem.rightBarButtonItems = buttons
        
        
    }
    
    @objc func saveButtonClicked() {
        guard let book = book else { return }
        do {
            try realm.write {
                realm.add(book)
            }
        } catch {
            print("save error")
        }
    }
    
    @objc func updateButtonClicked() {
        guard let book = book else { return }
        //let item = BookTable(value: ["_id": book._id, "memo": memoTextView.text ?? nil])
        
        do {
            try realm.write {
                book.memo = memoTextView.text
                //realm.add(item, update: .modified)
            }
        } catch {
            print("")
        }
        
        //print(book)
        dismiss(animated: true)
    }
    
    @objc func deleteButtonClicked() {
        if let book {
            removeImageFromDocument(fileName: "book_\(book._id).jpg")

            try! realm.write {
                realm.delete(book)
            }
            
            dismiss(animated: true)
            
        }
        
    }
    
    
   
    
    func setValues() {
        if let book {
            //print(book)
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
            
            memoTextView.text = book.memo
            
            
            
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
        memoTextView.layer.borderColor = UIColor.darkGray.cgColor
        memoTextView.layer.borderWidth = 1
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissButton))
        title = book.title
    }
    
    @objc func dismissButton() {
        dismiss(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if placeholder == textView.text {
            textView.text = nil
            textView.textColor = .black
        } else {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }


    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }

}
