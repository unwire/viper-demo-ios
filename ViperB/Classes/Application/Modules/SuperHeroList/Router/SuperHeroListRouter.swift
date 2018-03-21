//
//  SuperHeroListRouter.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


class SuperHeroListRouter: EnvironmentConsumer, SuperHeroListRouterType {

    weak var baseView: UIViewController?
    var detailsBuilder: SuperHeroDetailsBuilder?

    func open(model: SuperHeroListModelType) {
        let builder = SuperHeroDetailsBuilder(environment: environment,
                                              model: model,
                                              delegate: self)
        let viewController = builder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.baseView?.present(navigationController, animated: true, completion: nil)
        detailsBuilder = builder
    }
}

extension SuperHeroListRouter: SuperHeroDetailsBuilderDelegate {
    func didCloseSuperHeroDetailsModule() {
        detailsBuilder = nil
        baseView?.dismiss(animated: true, completion: nil)
    }
}
