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
            self.viewModel.getImageData()
        }
        
        viewModel.photoImageData.bind { value in
            
            guard let value = value else {
                self.mainView.imageView.image = UIImage(systemName: "photo.fill")
                return
            }
            
            self.mainView.imageView.image = UIImage(data: value)
        }
        
    }
    
    
    
    @objc private func randomButtonClicked() {
        viewModel.fetchRandomPhoto()
    }
    
    
    
}


