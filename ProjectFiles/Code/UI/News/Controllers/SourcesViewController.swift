//
//  SourcesViewController.swift
//  ReactiveSwift-Demo
//
//  Created by Vaibhav Parmar on 08/08/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import Model

class SourcesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var sourceCellModels: [SourceCellModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var sources: [Source] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.prepareSourceModel()
    }

    func prepareSourceModel() {
        self.sourceCellModels = self.sources.map {
            SourceCellModel($0)
        }
    }
    
}

//MARK: UITableViewDataSource
extension SourcesViewController: UITableViewDataSource {
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerCell(SourceTableCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(SourceTableCell.self, for: indexPath)
        cell.item = self.sourceCellModels[indexPath.row]
        return cell
    }
}

//MARK: UITableViewDelegate
extension SourcesViewController: UITableViewDelegate {
    
}
