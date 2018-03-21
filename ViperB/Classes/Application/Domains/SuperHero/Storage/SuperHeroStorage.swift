//
//  SuperHeroStorage.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Implements im-memory storage of heroes.
/// TODO: Implement real storage (NSCodying or Core Data).
class SuperHeroStorage: SuperHeroStorageType {

    private var stored: [SuperHeroEntityType]?

    func load() -> [SuperHeroEntityType]? {
        return stored
    }

    func save(superHeroes: [SuperHeroEntityType]) {
        stored = superHeroes
    }

    func delete() {
        stored = nil
    }
}
