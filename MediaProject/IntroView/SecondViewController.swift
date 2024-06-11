//
//  SecondViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/08/25.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "MoreImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let label = {
        let view = UILabel()
        view.text = "More Information"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let button = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "Skip"
        config.baseForegroundColor = .black
        config.titleAlignment = .center
        view.configuration = config
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.snp.makeConstraints { make in
            make.topMargin.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
            
            
        }
        
        
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottomMargin).offset(100)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottomMargin).offset(100)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottomMargin.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
    }
    @objc func buttonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: TrendViewController.identifier) as! TrendViewController
        //let nav = UINavigationController(rootViewController: vc)
        UserDefaults.standard.set(true, forKey: "isLaunched")
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
