//
//  SuperHeroListRouterMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit
@testable import ViperB

class SuperHeroListRouterMock: SuperHeroListRouterType {
    weak var baseView: UIViewController?
    private(set) var openCalled: Bool?
    func open(model: SuperHeroListModelType) {
        openCalled = true
    }
}
