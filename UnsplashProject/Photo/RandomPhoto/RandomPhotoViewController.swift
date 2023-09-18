//
//  RandomPhotoViewController.swift
//  UnsplashProject
//
//  Created by 김지연 on 2023/09/19.
//

import UIKit
import SnapKit

class RandomPhotoViewController: UIViewController {
    
    let mainView = RandomView()
    let viewModel = RandomPhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        configure()
        
    }
    
    func configure() {
        
        view.backgroundColor = .white
        mainView.randomButton.addTarget(self, action: #selector(randomButtonClicked), for: .touchUpInside)
        
        viewModel.photo.bind { value in
            self.getUIImage(url: value.urls?.thumb)
        }
        
    }
    
    func getUIImage(url: String?) {
        
        DispatchQueue.global().async {
            guard let imageString = self.viewModel.photo.value.urls?.thumb else {
                DispatchQueue.main.async {
                    self.mainView.imageView.image = UIImage(systemName: "photo.fill")
                }
                return
            }
            guard let url = URL(string: imageString) else {
                DispatchQueue.main.async {
                    self.mainView.imageView.image = UIImage(systemName: "photo.fill")
                }
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.mainView.imageView.image = UIImage(systemName: "photo.fill")
                }
                return
            }
            DispatchQueue.main.async {
                self.mainView.imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    
    @objc private func randomButtonClicked() {
        viewModel.fetchRandomPhoto()
    }
    
    
    
}


