//
//  SuperHeroStorageType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Defines interface for storing heroes.
protocol SuperHeroStorageType {

    /// Loads stored heroes.
    ///
    /// - Returns: List of heroes, or nil if nothing was saved yet.
    func load() -> [SuperHeroEntityType]?

    /// Saves heroes.
    ///
    /// - Parameter superHeroes: Heroes to save.
    func save(superHeroes: [SuperHeroEntityType])

    /// Deletes all saved heroes (clears storage).
    func delete()
}
