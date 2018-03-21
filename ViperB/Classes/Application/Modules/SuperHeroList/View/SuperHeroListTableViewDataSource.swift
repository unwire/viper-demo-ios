//
//  SuperHeroListTableViewDataSource.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 16/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


class SuperHeroListTableViewDataSource: NSObject, UITableViewDataSource {

    private let cellId = "CellId"
    
    // ?? weak?
    let presenter: SuperHeroListPresenterType

    init(presenter: SuperHeroListPresenterType) {
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfListItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? SuperHeroListItemTableViewCell
        if cell == nil {
            cell = SuperHeroListItemTableViewCell(reuseIdentifier: cellId)
        }
        let itemViewModel = presenter.listItemViewModel(at: indexPath.row)
        cell?.update(with: itemViewModel)
        return cell!
    }

}
