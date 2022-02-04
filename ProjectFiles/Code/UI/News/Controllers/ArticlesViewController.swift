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
import FLUtilities

class ArticlesViewController: UIViewController {

    struct Segue {
        static let webView = "WebViewSegueId"
    }
    
    @IBOutlet var tableView: UITableView!
    
    var source: Source!
    var articleViewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.prepareArticleModel()
    }
    
    private func prepareArticleModel() {
        let disposable = self.articleViewModel.disposable
        self.fetchArticles(from: source)
        disposable += self.view.reactive.showLoader <~ self.articleViewModel.loading.map { $0 }
        disposable += self.articleViewModel.cellModels.signal.observeValues({ _ in
            self.tableView.reloadData()
        })
        disposable += self.articleViewModel.error.signal.observeValues({ error in
            guard let error = error else { return }
            self.handleError(error)
        })
    }
    
    private func fetchArticles(from source: Source, sortyBy: SortBy = .top) {
        self.articleViewModel.fetchArticles(from: source, sortBy: sortyBy)
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
            guard let url = URL(string: loadUrl) else { return }
            let newsViewModel = NewsViewModel(loadUrl: url)
            vc.newsViewModel = newsViewModel
        default: break
        }
        super.prepare(for: segue, sender: sender)

    }
}


extension ArticlesViewController {
    @IBAction func handleSortByTapped(_ sender: UIBarButtonItem) {
        
        let top = ActionInterface(title: SortBy.top.value, style: .default)
        let latest = ActionInterface(title: SortBy.latest.value, style: .default)
        let popular = ActionInterface(title: SortBy.popular.value, style: .default)
        let cancel = ActionInterface(title: "Cancel", style: .cancel)
        
        self.showActionSheet(title: "SortBy", message: nil,
                             actionInterfaceList: [top, latest, popular, cancel]) { interface in
                                
            switch interface.title {
            case SortBy.top.value:
                self.fetchArticles(from: self.source, sortyBy: .top)
            case SortBy.latest.value:
                self.fetchArticles(from: self.source, sortyBy: .latest)
            case SortBy.popular.value:
                self.fetchArticles(from: self.source, sortyBy: .popular)
            default: break
            }
        }
    }
    
}
