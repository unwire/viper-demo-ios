//
//  SuperHeroListPresenterType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation



protocol SuperHeroListPresenterDelegate: class {

    func didUpdate(viewModel: SuperHeroListViewModelType)

    func didUpdateListItemViewModel(at index: Int)
}

protocol SuperHeroListPresenterType: PresenterType {

    func numberOfListItems() -> Int

    func listOptionChanged(option: Int)

    func listItemViewModel(at index: Int) -> SuperHeroListItemViewModelType

    func didTapListItemViewModel(at index: Int)
}
