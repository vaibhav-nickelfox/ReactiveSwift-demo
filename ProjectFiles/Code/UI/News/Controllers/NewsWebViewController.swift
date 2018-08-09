//
//  NewsWebViewController.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {

    @IBOutlet var webViewContainer: UIView!
    
    var webView: WKWebView!
    var loadUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
    }
}

extension NewsWebViewController: WKNavigationDelegate {
    
    func setupWebView() {
        self.webView = WKWebView()
        self.webView.navigationDelegate = self
        self.webViewContainer.addAndFitSubview(view: self.webView)
        guard let urlLink = self.loadUrl,
            let url = URL(string: urlLink) else { return }
        self.webView.load(URLRequest(url: url))
        self.showLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
    }

}
