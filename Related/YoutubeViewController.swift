//
//  YoutubeViewController.swift
//  MediaProject
//
//  Created by 김지연 on 2023/09/03.
//

import UIKit
import WebKit

class YoutubeViewController: BaseViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var url: URL?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let url = url {
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        } else {
            dismiss(animated: true)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = false
        
        
        
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
}
