//
//  HomeViewController.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit
import Hero

class HomeViewController: UIViewController {
    
    private let myView: HomeView
    private let viewModel: HomeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        navigationItem.titleView = viewModel.titleView
        
        viewModel.loadData()
    }
    
    override func loadView() {
        view = myView
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.myView = HomeView()

        super.init(nibName: nil, bundle: nil)
        
        viewModel.viewDelegate = self
        hero.isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func dataLoaded() {
        myView.tableView.reloadData()
    }
    
    func idle() {
        myView.isBusy = false
    }
    
    func busy() {
        myView.isBusy = true
    }
    
    func showError(model: AlertViewModel) {
        showAlert(using: model)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = viewModel.itemModel(at: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(at: indexPath)
    }
}
