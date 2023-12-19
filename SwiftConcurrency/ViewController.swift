//
//  ViewController.swift
//  SwiftConcurrency
//
//  Created by 김지연 on 12/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var posterImageView2: UIImageView!
    
    @IBOutlet var posterImageView3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        Task {
//            let image1 = try await Network.shared.fetchThumbnailAsyncAwait(value: "aZuBfbR0PnCb2up7lqHDsgJlLjs")
//            let image2 = try await Network.shared.fetchThumbnailAsyncAwait(value: "lMWTlGr9jVUC18T515hPRKym5QQ")
//            let image3 = try await Network.shared.fetchThumbnailAsyncAwait(value: "7M2pc9OboapgtoBbkU49Aim7O5B")
//            
//            posterImageView.image = image1
//            posterImageView2.image = image2
//            posterImageView3.image = image3
//        }
        
        
//        Task {
//            let result = try await Network.shared.fetchThumbnailAsyncLet()
//            posterImageView.image = result[0]
//            posterImageView2.image = result[1]
//            posterImageView3.image = result[2]
//        }
        
        Task {
            let value = try await Network.shared.fetchThumbnailTaskGroup()
            posterImageView.image = value[0]
            posterImageView2.image = value[1]
            posterImageView3.image = value[2]

        }
        
    }


}

