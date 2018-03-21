//
//  SuperHeroListBuilder.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


/// Implements builder for the default superhero list module.
class SuperHeroListBuilder: EnvironmentConsumer, BuilderType {

    func build() -> UIViewController {
        let interactor = SuperHeroListInteractor(superHeroDataManager: environment.superHeroDataManager,
                                                 imageDataManager: environment.imageDataManager)
        let router = SuperHeroListRouter(environment: environment)
        let presenter = SuperHeroListPresenter(interactor: interactor, router: router)
        let dataSource = SuperHeroListTableViewDataSource(presenter: presenter)
        let delegate = SuperHeroListTableViewDelegate(presenter: presenter)
        let view = SuperHeroListViewController<SuperHeroListPresenter>(presenter: presenter,
                                                                       dataSource: dataSource,
                                                                       delegate: delegate)
        interactor.delegate = presenter
        presenter.delegate = view
        router.baseView = view
        return view
    }
}
