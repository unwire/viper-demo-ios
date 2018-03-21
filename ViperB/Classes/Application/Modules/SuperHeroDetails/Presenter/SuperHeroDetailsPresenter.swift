//
//  SuperHeroDetailsPresenter.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


class SuperHeroDetailsPresenter: SuperHeroDetailsPresenterType {

    let interactor: SuperHeroDetailsInteractorType
    let router: SuperHeroDetailsRouterType
    weak var delegate: SuperHeroDetailsPresenterDelegate?

    var loadedModel: SuperHeroDetailsModelType? = nil

    init(interactor: SuperHeroDetailsInteractorType,
         router: SuperHeroDetailsRouterType) {
        self.interactor = interactor
        self.router = router
    }

    func viewWillBecomeActive() {
        updateViewModel(model: loadedModel)
    }

    func didTapClose() {
        router.close()
    }


    // MARK: Private

    private func updateViewModel(model: SuperHeroDetailsModelType?) {
        // Show loading indicator:
        delegate?.didUpdate(viewModel: SuperHeroDetailsViewModel(model: nil, isLoading: true))
        // Load hero:
        interactor.loadSuperHeroDetails { [weak self] result in
            var model: SuperHeroDetailsModelType? = nil
            var error: Error? = nil
            switch result {
            case .success(let m):
                model = m
            case .failure(let e):
                error = e
            }
            self?.loadedModel = model
            let viewModel = SuperHeroDetailsViewModel(model: model, isLoading: false, error: error)
            // Update view model and hide loading indicator:
            self?.delegate?.didUpdate(viewModel: viewModel)
        }
    }
}

// MARK: SuperHeroDetailsInteractorDelegate

extension SuperHeroDetailsPresenter: SuperHeroDetailsInteractorDelegate {
    func didUpdate(model: SuperHeroDetailsModelType) {
        loadedModel = model
        let viewModel =  SuperHeroDetailsViewModel(model: loadedModel, isLoading: false)
        delegate?.didUpdate(viewModel: viewModel)
    }
}
