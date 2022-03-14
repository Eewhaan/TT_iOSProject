//
//  InfoViewController.swift
//  TT_iOSProject
//
//  Created by Ivan Pavic on 14.3.22..
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Info"
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: webView, action: #selector(webView.reload))
        swipeGestureRecognizer.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        let url = URL(string: "https://drive.google.com/file/d/1nhew3QQgarqaexQ5Fmt4eT6hHR7yeC1B/view?usp=sharing")
        guard let url = url else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

    }
    

}
