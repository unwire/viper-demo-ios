//
//  SuperHeroDetailsInteractorDelegateMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroDetailsInteractorDelegateMock: SuperHeroDetailsInteractorDelegate {
    private(set) var updatedModel: SuperHeroDetailsModelType?
    func didUpdate(model: SuperHeroDetailsModelType) {
        updatedModel = model
    }
    

}
