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
        guard let book = book else { dismiss(animated: true); return }
       
        
        setProperties()
        setValues()
        configBarButtonItem()
        
    }
    
    func configBarButtonItem() {
        var buttons: [UIBarButtonItem]?
        
        
        
        let likeButtonImage = book!.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            
        let like = UIBarButtonItem(image: likeButtonImage, style: .plain, target: self, action: #selector(likeButtonClicked))
        like.tintColor = .red
        buttons = [like]
        
        if viewTransition == .main {
            
            let update = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(updateButtonClicked))
            update.tintColor = .systemBlue
            buttons = [like, update]
        } else {
            memoTextView.isHidden = true
        }
        
       
        navigationItem.rightBarButtonItems = buttons
        
        
    }
    
    @objc func updateButtonClicked() {
        guard let book = book else { return }
        
        do {
            try realm.write {
                book.memo = memoTextView.text
            }
        } catch {
            print("")
        }
        
        //print(book)
        //dismiss(animated: true)
    }
    
    @objc func likeButtonClicked() {
        
        guard let book = book else { return }
        print(book.like)
        if book.like {
            removeImageFromDocument(fileName: "book_\(book._id).jpg")
            do {
                try realm.write {
                    realm.delete(book)
                }
            } catch {
                print("delete error")
            }
            
            
            
        } else {
            book.like = true
            do {
                try realm.write {
                    
                    realm.add(book)
                }
            } catch {
                print("save error")
            }
        }
        
        dismiss(animated: true)
        
    }
    
   
   
    
    func setValues() {
        if let book {
            //print(book)
            bookTitleLabel.text = book.title
            bookInfoLabel.text = "\(book.author) | \(book.publisher)"
            contentsLabel.text = book.contents
            priceLabel.text = "\(book.price)원"
            memoTextView.text = book.memo
            
            guard let url = URL(string: book.poster) else {
                posterImageView.image = UIImage(systemName: "book.closed.fill")!
                return
            }
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }

            }
            saveImageToDocument(fileName: "book_\(book._id).jpg", image: book.poster)
            posterImageView.image = loadImageFromDocument(fileName: "book_\(book._id).jpg")
            
            
            
            
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
        //title = book.title
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
