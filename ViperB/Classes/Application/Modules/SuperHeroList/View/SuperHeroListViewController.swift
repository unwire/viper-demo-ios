//
//  SuperHeroListViewController.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit



class SuperHeroListViewController<P: SuperHeroListPresenterType>: ViperViewController<P> {

    let tableViewDataSource: UITableViewDataSource
    let tableViewDelegate: UITableViewDelegate

    fileprivate lazy var tableView: UITableView = { [weak self] in
        let table = UITableView(frame: .zero, style: .plain)
        let fakeFooter = UIView(frame: .zero)
        table.tableFooterView = fakeFooter
        table.rowHeight = 100
        table.delegate = self?.tableViewDelegate
        table.dataSource = self?.tableViewDataSource
        return table
    }()

    fileprivate lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    fileprivate lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()

    fileprivate lazy var optionControl: UISegmentedControl = {
        let control = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 120, height: 31))
        control.addTarget(self, action: #selector(optionChanged), for: UIControlEvents.valueChanged)
        return control
    }()

    init(presenter: P, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.tableViewDataSource = dataSource
        self.tableViewDelegate = delegate
        super.init(presenter: presenter)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK - View life cycle

    override func loadView() {
        statusLabel.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: statusLabel.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor, constant: -50).isActive = true
        tableView.backgroundView = statusLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionControl)
        view = tableView
    }
    @objc func optionChanged() {
        presenter.listOptionChanged(option: optionControl.selectedSegmentIndex)
    }

}

// MARK: SuperHeroListPresenterDelegate

extension SuperHeroListViewController: SuperHeroListPresenterDelegate {

    func didUpdateListItemViewModel(at index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            let indexPath = IndexPath(row: index, section: 0)
            wSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    func didUpdate(viewModel: SuperHeroListViewModelType) {
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            wSelf.title = viewModel.title
            wSelf.statusLabel.text = viewModel.statusText
            viewModel.showLoadingIndicator ? wSelf.loadingIndicator.startAnimating() : wSelf.loadingIndicator.stopAnimating()
            wSelf.tableView.reloadData()
            wSelf.optionControl.removeAllSegments()
            for option in viewModel.options.reversed() {
                wSelf.optionControl.insertSegment(withTitle: option, at: 0, animated: false)
            }
           wSelf.optionControl.selectedSegmentIndex = viewModel.selectedOption
        }
    }
}
