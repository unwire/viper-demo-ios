//
//  SuperHeroDetailsPresenterDelegateMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroDetailsPresenterDelegateMock: SuperHeroDetailsPresenterDelegate {
    private(set) var updatedModel: SuperHeroDetailsViewModelType?
    func didUpdate(viewModel: SuperHeroDetailsViewModelType) {
        updatedModel = viewModel
    }
}
