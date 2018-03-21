//
//  SuperHeroDetailsRouterMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 21/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit
@testable import ViperB

class SuperHeroDetailsRouterMock: SuperHeroDetailsRouterType {
    weak var baseView: UIViewController?
    private(set) var closeCalled: Bool?

    func close() {
        closeCalled = true
    }
}
