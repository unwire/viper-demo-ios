//
//  SuperHeroListPresenterDelegateMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroListPresenterDelegateMock: SuperHeroListPresenterDelegate {
    private(set) var updatedIndex: Int?
    private(set) var updatedModel: SuperHeroListViewModelType?

    func didUpdateListItemViewModel(at index: Int) {
        updatedIndex = index
    }
    func didUpdate(viewModel: SuperHeroListViewModelType) {
        updatedModel = viewModel
    }
}
