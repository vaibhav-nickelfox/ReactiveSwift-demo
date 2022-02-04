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
    
    var categoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.prepareCategoryModel()
    }
    
    private func prepareCategoryModel() {
        let disposable = self.categoryViewModel.disposable
        self.categoryViewModel.fetchSources()
        
        disposable += self.view.reactive.showLoader <~ self.categoryViewModel.loading
        
        disposable += self.categoryViewModel.cellModels.signal.observeValues({ _ in
            self.tableView.reloadData()
        })
        disposable += self.categoryViewModel.error.signal.observeValues({ error in
            guard let error = error else { return }
            self.handleError(error)
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
        return self.categoryViewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(CategoryTableCell.self, for: indexPath)
        cell.item = self.categoryViewModel.cellModel(at: indexPath)
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
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryCellModel = self.categoryViewModel.cellModel(at: indexPath)
        self.performSegue(withIdentifier: Segue.sourcesView, sender: categoryCellModel.sources)
    }
}


//MARK: Segue
extension CategoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.sourcesView, let vc as SourcesViewController, let sources as [Source]):
            let sourceViewModel = SourceViewModel()
            sourceViewModel.setSources(sources)
            vc.sourceViewModel = sourceViewModel
        default: break
        }
        super.prepare(for: segue, sender: sender)
    }
}
