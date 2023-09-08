//
//  TabbarController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/07.
//

import UIKit

class TabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = TrendCollectionViewController()
        let vc2 = ProfileViewController()
        
        vc1.title = "Trend"
        vc2.title = "Profile"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        
        setViewControllers([nav1, nav2], animated: true)
        
    }
}
