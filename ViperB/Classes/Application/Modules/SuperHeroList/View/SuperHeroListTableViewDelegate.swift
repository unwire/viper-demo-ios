//
//  SuperHeroListTableViewDelegate.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 16/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


class SuperHeroListTableViewDelegate: NSObject, UITableViewDelegate {
    
    // ?? weak?
    let presenter: SuperHeroListPresenterType

    init(presenter: SuperHeroListPresenterType) {
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapListItemViewModel(at: indexPath.row)
    }
}
