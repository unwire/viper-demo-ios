//
//  SuperHeroDataManager.swift
//  
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//

import Foundation


class SuperHeroDataManager: SuperHeroDataManagerType {
    let service: SuperHeroServiceType
    let storage: SuperHeroStorageType

    init(service: SuperHeroServiceType, storage: SuperHeroStorageType) {
        self.service = service
        self.storage = storage
    }

    func load(completion complete: @escaping (SuperHeroDataManagerTypeResult) -> Void) {
        if let stored = storage.load() {
            complete(.success(stored))
            return
        }
        service.load { [weak self] result in
            switch result {
            case .failure(_):
                complete(.failure(.loadError))
            case .success(let entities):
                if let heroes = entities {
                    self?.storage.save(superHeroes: heroes)
                } else {
                    self?.storage.delete()
                }
                complete(.success(entities))
            }
        }
    }
}
