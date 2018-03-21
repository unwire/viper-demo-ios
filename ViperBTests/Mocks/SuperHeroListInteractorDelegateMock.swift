//
//  SuperHeroListInteractorDelegateMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroListInteractorDelegateMock: SuperHeroListInteractorDelegate {
    private(set) var updatedModel: SuperHeroListModelType?
    func didUpdate(model: SuperHeroListModelType) {
        updatedModel = model
    }
}
