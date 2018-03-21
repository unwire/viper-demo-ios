//
//  SuperHeroDetailsBuilder.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


protocol SuperHeroDetailsBuilderDelegate: class {
    func didCloseSuperHeroDetailsModule()
}

class SuperHeroDetailsBuilder: EnvironmentConsumer, BuilderType {

    weak var delegate: SuperHeroDetailsBuilderDelegate?

    let model: SuperHeroListModelType

    init(environment: EnvironmentType,
         model: SuperHeroListModelType,
         delegate: SuperHeroDetailsBuilderDelegate) {
        self.model = model
        self.delegate = delegate
        super.init(environment: environment)
    }

    func build() -> UIViewController {
        let router = SuperHeroDetailsRouter(environment: environment)
        let interactor = SuperHeroDetailsInteractor(superHeroId: model.id,
                                                    superHeroDataManager: environment.superHeroDataManager,
                                                    imageDataManager: environment.imageDataManager)
        let presenter = SuperHeroDetailsPresenter(interactor: interactor, router: router)
        let view = SuperHeroDetailsViewController<SuperHeroDetailsPresenter>(presenter: presenter)
        interactor.delegate = presenter
        presenter.delegate = view
        router.baseView = view
        router.delegate = self
        return view
    }
}

extension SuperHeroDetailsBuilder: SuperHeroDetailsRouterDelegate {
    func didCloseSuperHeroDetails() {
        delegate?.didCloseSuperHeroDetailsModule()
    }
}
