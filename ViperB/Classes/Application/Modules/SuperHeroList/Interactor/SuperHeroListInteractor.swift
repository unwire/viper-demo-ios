//
//  SuperHeroListInteractor.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation

fileprivate enum LoadMode {
    case alphabetical
    case rank(limit: Int)
}


class SuperHeroListInteractor: SuperHeroListInteractorType {

    let superHeroDataManager: SuperHeroDataManagerType
    let imageDataManager: ImageDataManagerType
    weak var delegate: SuperHeroListInteractorDelegate?

    init(superHeroDataManager: SuperHeroDataManagerType,
         imageDataManager: ImageDataManagerType) {
        self.superHeroDataManager = superHeroDataManager
        self.imageDataManager = imageDataManager
    }


    // MARK: Public API

    func loadAllSortedAlphabetically(completion complete: @escaping (SuperHeroListInteractorTypeResult) -> Void) {
        load(mode: .alphabetical, completion: complete)
    }

    func loadTop10(completion complete: @escaping (SuperHeroListInteractorTypeResult) -> Void) {
        load(mode: .rank(limit: 10), completion: complete)
    }

    func loadImage(for model: SuperHeroListModelType) {
        // Interactor decides when to download new image.
        // In this implementation we only downlaod mage if it is not stored or cached.
        guard imageDataManager.image(for: model.imageUrl) == nil else { return }
        imageDataManager.loadImage(for: model.imageUrl) { [weak self] result in
            var imageData: Data? = nil
            switch result {
            case .success(let image):
                imageData = image.data
            case .failure(_):
                break
            }
            guard imageData != model.imageData else { return }
            self?.delegate?.didUpdate(model: SuperHeroListModel(model: model, imageData: imageData))
        }
    }

    // MARK: Private

    private func load(mode: LoadMode, completion complete: @escaping (SuperHeroListInteractorTypeResult) -> Void) {
        superHeroDataManager.load { result in
            switch result {
            case .success(let entities):
                guard let entities = entities else {
                    complete(.success([]))
                    return
                }
                let models = self.process(entities: entities, mode: mode)
                complete(.success(models))
            case .failure(_):
                complete(.failure(.loadError))
            }
        }
    }

    private func process(entities: [SuperHeroEntityType], mode: LoadMode) -> [SuperHeroListModel] {
        var processed = entities.sorted { (s1, s2) -> Bool in
            switch mode {
            case .alphabetical:
                return s1.name < s2.name
            case .rank(_):
                return s1.rank < s2.rank
            }
        }
        switch mode {
        case .rank(let limit):
            processed = Array(processed.prefix(limit))
        case .alphabetical:
            break
        }
        let models = processed.map { entity -> SuperHeroListModel in
            let cachedImage = imageDataManager.image(for: entity.imageUrl)
            return SuperHeroListModel(hero: entity, image: cachedImage)
        }
        return models
    }
}
