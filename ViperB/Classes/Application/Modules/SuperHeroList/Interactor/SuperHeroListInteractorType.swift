//
//  SuperHeroListInteractorType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum SuperHeroListInteractorError: Error {
    case loadError
    case loadImageError
    case networkError
}

typealias SuperHeroListInteractorTypeResult = Result<[SuperHeroListModelType], SuperHeroListInteractorError>

protocol SuperHeroListInteractorDelegate: class {
    func didUpdate(model: SuperHeroListModelType)
}

protocol SuperHeroListInteractorType: InteractorType {

    func loadImage(for model: SuperHeroListModelType)

    func loadAllSortedAlphabetically(completion: @escaping (SuperHeroListInteractorTypeResult) -> Void)

    func loadTop10(completion: @escaping (SuperHeroListInteractorTypeResult) -> Void)
}
