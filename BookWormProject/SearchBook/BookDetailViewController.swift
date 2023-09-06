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
    
    @IBOutlet var likeButton: UIButton!
    
    var book: BookTable?
    var bookId: ObjectId?
    let repository = BookTableRepository()
    let placeholder = "메모를 입력하세요."
    var viewTransition: ViewTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else { dismiss(animated: true); return }
       
        
        setProperties()
        setValues()
        configBarButtonItem()
        setLikeButtonImage(like: book.like)
        
        
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        guard let book = book else { return }
        
        
        if book.like {
            removeImageFromDocument(fileName: "book_\(book._id).jpg")
            repository.deleteItem(book)
            
            
            
        } else {
            book.like = true
            repository.createItem(book)
            saveImageToDocument(fileName: "book_\(book._id).jpg", image: book.posterURL)
        }
        
        dismiss(animated: true)
    }
    
    func configBarButtonItem() {
        
        if viewTransition == .main {
            let update = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down.fill"), style: .plain, target: self, action: #selector(updateButtonClicked))
            update.tintColor = .systemBlue
            navigationItem.rightBarButtonItem = update
        } else {
            memoTextView.isHidden = true
        }
        
       
        
        
        
    }
    
    @objc func updateButtonClicked() {
        guard let book = book else { return }
        let memo = memoTextView.text.trimmingCharacters(in: .whitespaces)
        
        repository.updateItem(id: book._id, memo: memo.count == 0 ? "" : memo)
        
        
    }
    
    
   
    
    func setValues() {
        if let book {
            //print(book)
            bookTitleLabel.text = book.title
            bookInfoLabel.text = book.info
            contentsLabel.text = book.contents
            priceLabel.text = "\(book.price)원"
            memoTextView.text = book.memo
            
            guard let url = URL(string: book.posterURL) else {
                posterImageView.image = UIImage(systemName: "book.closed.fill")!
                return
            }
            DispatchQueue.global().async {
                let data = try! Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }

            }
            
            posterImageView.image = loadImageFromDocument(fileName: "book_\(book._id).jpg")
            
            
            
            
        }
    }
    
    
    func setLikeButtonImage(like: Bool) {
        let img = like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(img, for: .normal)
        likeButton.tintColor = .red
    }
    
    func setProperties() {
        
        
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
        
        //let likeImage = UIImage(systemName: "heart")!
        
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissButton))
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
