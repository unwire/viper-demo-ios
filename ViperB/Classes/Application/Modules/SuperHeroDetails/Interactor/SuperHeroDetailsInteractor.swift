//
//  SuperHeroDetailsInteractor.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


class SuperHeroDetailsInteractor: SuperHeroDetailsInteractorType {

    let superHeroDataManager: SuperHeroDataManagerType
    let imageDataManager: ImageDataManagerType
    weak var delegate: SuperHeroDetailsInteractorDelegate?

    let superHeroId: Int

    init(superHeroId id: Int,
         superHeroDataManager: SuperHeroDataManagerType,
         imageDataManager: ImageDataManagerType) {
        self.superHeroId = id
        self.superHeroDataManager = superHeroDataManager
        self.imageDataManager = imageDataManager
    }

    func loadSuperHeroDetails(completion complete: @escaping (Result<SuperHeroDetailsModelType, SuperHeroDetailsInteractorError>) -> Void) {
        superHeroDataManager.load { [weak self] result in
            switch result {
            case .success(let entities):
                guard let entities = entities else {
                    complete(.failure(.noDetails))
                    return
                }
                guard let wSelf = self, let entity = entities.first(where: { (entity) -> Bool in
                    return entity.id == wSelf.superHeroId
                }) else {
                    complete(.failure(.noDetails))
                    return
                }
                let image = self?.imageDataManager.image(for: entity.imageUrl)
                let model = SuperHeroDetailsModel(entity: entity, image: image)
                complete(.success(model))
                wSelf.loadImageIfNeeded(loadedModel: model, entity: entity)
            case .failure(_):
                complete(.failure(.loadError))
            }
        }
    }


    // MARK: Private

    private func loadImageIfNeeded(loadedModel model: SuperHeroDetailsModelType?, entity: SuperHeroEntityType) {
        // Load image only of loaded entity and if no image is there.
        guard let loadedModel = model, loadedModel.imageData == nil else {
            return
        }
        imageDataManager.loadImage(for: entity.imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                let model = SuperHeroDetailsModel(entity: entity, image: image)
                self?.delegate?.didUpdate(model: model)
            case .failure(_):
                break
            }
        }
    }
}
