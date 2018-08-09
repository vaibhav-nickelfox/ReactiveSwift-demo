//
//  ArticlesViewController.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import Model
import ReactiveCocoa
import ReactiveSwift

class ArticlesViewController: UIViewController {

    struct Segue {
        static let webView = "WebViewSegueId"
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var source: Source!
    var articleViewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.prepareArticleModel()
    }
    
    private func prepareArticleModel() {
        self.articleViewModel.fetchArticles(from: self.source)        
        self.articleViewModel.disposable += self.activityIndicatorView.reactive.isAnimating <~ self.articleViewModel.loading.map { $0 }
        self.articleViewModel.disposable += self.articleViewModel.cellModels.signal.observeValues({ _ in
            self.tableView.reloadData()
        })
    }
}

//MARK: UITableViewDataSource
extension ArticlesViewController: UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(ArticleTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ArticleTableCell.self, for: indexPath)
        cell.item = self.articleViewModel.cellModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: UITableViewDelegate
extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.articleViewModel.cellModels.value[indexPath.row].urlLink
        self.performSegue(withIdentifier: Segue.webView, sender: url)
    }
}

//MARK: Segue
extension ArticlesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.webView, let vc as NewsWebViewController, let loadUrl as String):
            vc.loadUrl = loadUrl
        default: break
        }
        super.prepare(for: segue, sender: sender)

    }
}
