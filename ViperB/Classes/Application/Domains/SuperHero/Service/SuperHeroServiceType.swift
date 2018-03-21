//
//  SuperHeroServiceType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum SuperHeroServiceError: Error {
    case invalidUrl
    case noSuperHeroData
    case invalidSuperHeroData
    case networkError(Error)
}

typealias SuperHeroServiceTypeResult = Result<[SuperHeroEntityType]?, SuperHeroServiceError>

protocol SuperHeroServiceType {
    func load(completion: @escaping (SuperHeroServiceTypeResult) -> Void)
}
