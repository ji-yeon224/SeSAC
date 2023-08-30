//
//  WebViewController.swift
//  PhotoGram
//
//  Created by 김지연 on 2023/08/29.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    var webView = WKWebView()
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(100)
        }
        
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        
        
        title = "타이틀"
    }
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        // 이전 페이지에 대한 히스토리가 있다면
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
