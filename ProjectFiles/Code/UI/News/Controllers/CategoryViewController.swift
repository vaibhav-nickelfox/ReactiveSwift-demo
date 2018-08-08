//
//  CategoryViewController.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import Model
import ReactiveSwift
import ReactiveCocoa

class CategoryViewController: UIViewController {

    struct Segue {
        static let sourcesView = "SourcesViewSegueId"
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var categoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.prepareCategoryModel()
    }

    private func prepareCategoryModel() {
        self.categoryViewModel.fetchSources()
        self.categoryViewModel.disposable += self.activityIndicatorView.reactive.isHidden <~ self.categoryViewModel.loading.map { !$0 }
        self.categoryViewModel.disposable += self.categoryViewModel.cellModels.signal.observeValues({ _ in
            self.tableView.reloadData()
        })
    }
}


//MARK: UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
 
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(CategoryTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryViewModel.cellModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CategoryTableCell.self, for: indexPath)
        cell.item = self.categoryViewModel.cellModels.value[indexPath.item]
        return cell
    }
}

//MARK: UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCellModel = self.categoryViewModel.cellModels.value[indexPath.row]
        self.performSegue(withIdentifier: Segue.sourcesView, sender: categoryCellModel.sources)
    }
}


//MARK: Segue
extension CategoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.sourcesView, let vc as SourcesViewController, let sources as [Source]):
            vc.sources = sources
        default: break
        }
        super.prepare(for: segue, sender: sender)
    }
}
