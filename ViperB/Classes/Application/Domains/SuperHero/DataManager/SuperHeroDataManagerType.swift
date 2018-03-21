//
//  SuperHeroDataManagerType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation

enum SuperHeroDataManagerError: Error {
    case loadError
}

typealias SuperHeroDataManagerTypeResult = Result<[SuperHeroEntityType]?, SuperHeroDataManagerError>

protocol SuperHeroDataManagerType: class {

    func load(completion: @escaping (SuperHeroDataManagerTypeResult) -> Void)
}
