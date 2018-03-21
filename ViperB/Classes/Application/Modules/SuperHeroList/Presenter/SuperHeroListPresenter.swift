//
//  SuperHeroListPresenter.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


class SuperHeroListPresenter: SuperHeroListPresenterType {

    let router: SuperHeroListRouterType
    let interactor: SuperHeroListInteractorType
    weak var delegate: SuperHeroListPresenterDelegate?

    var selectedOption: Int = 0

    fileprivate var models: [SuperHeroListModelType]?

    init(interactor: SuperHeroListInteractorType, router: SuperHeroListRouterType) {
        self.interactor = interactor
        self.router = router
    }

    func numberOfListItems() -> Int {
        guard let models = self.models else { return 0}
        return models.count
    }

    func listItemViewModel(at index: Int) -> SuperHeroListItemViewModelType {
        guard let models = self.models, index < numberOfListItems() else {
            // Throw error would be a better option for testing.
            fatalError("Wrong index: \(index)")
        }
        let model = models[index]
        interactor.loadImage(for: model)
        return SuperHeroListItemViewModel(model: model, rankText: "\(model.rank)", showRank: selectedOption == 1)
    }

    func didTapListItemViewModel(at index: Int) {
        guard let models = self.models, index < numberOfListItems() else { return }
        let model = models[index]
        router.open(model: model)
    }

    func listOptionChanged(option: Int) {
        selectedOption = option
        refresh()
    }


    func viewWillBecomeActive() {
        refresh()
    }


    // MARK: Private

    private func refresh() {
        updateViewModel(isLoading: true, error: nil)

        func process(result: SuperHeroListInteractorTypeResult) {
            switch result {
            case .failure(let error):
                self.updateViewModel(isLoading: false, error: error)
            case .success(let models):
                self.models = models
                self.updateViewModel(isLoading: false, error: nil)
            }
        }
        switch selectedOption {
        case 1:
            interactor.loadTop10(completion: ) { process(result: $0) }
        default:
            interactor.loadAllSortedAlphabetically { process(result: $0) }
        }

    }

    private func updateViewModel(isLoading: Bool, error: Error?) {
        let isEmpty = numberOfListItems() == 0
        var statusText = isEmpty ? "No heroes..." : nil
        if isLoading { statusText = "Loading heroes..." }
        let viewModel = SuperHeroListViewModel(title: "Heroes",
                                               statusText: statusText,
                                               showLoadingIndicator: isLoading, options: ["A-Z", "Top 10"], selectedOption: selectedOption)
        delegate?.didUpdate(viewModel: viewModel)
    }
}

extension SuperHeroListPresenter: SuperHeroListInteractorDelegate {
    func didUpdate(model updatedModel: SuperHeroListModelType) {
        guard let models = models, let index = models.index(where: { model -> Bool in
            return updatedModel.id == model.id
        }), index < models.count else {
            return
        }
        self.models?[index] = updatedModel
        delegate?.didUpdateListItemViewModel(at: index)
    }
}
