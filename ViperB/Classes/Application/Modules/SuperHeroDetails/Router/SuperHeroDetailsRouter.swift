//
//  SuperHeroDetailsRouter.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit

class SuperHeroDetailsRouter: EnvironmentConsumer, SuperHeroDetailsRouterType {
    weak var baseView: UIViewController?
    weak var delegate: SuperHeroDetailsRouterDelegate?

    func close() {
        delegate?.didCloseSuperHeroDetails()
    }
}
