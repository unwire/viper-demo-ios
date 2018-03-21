//
//  SuperHeroDetailsInteractorType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum SuperHeroDetailsInteractorError: Error {
    case noDetails
    case loadError
    case loadImageError
    case networkError
}

protocol SuperHeroDetailsInteractorType: InteractorType {
    func loadSuperHeroDetails(completion: @escaping (Result<SuperHeroDetailsModelType, SuperHeroDetailsInteractorError>) -> Void)
}


protocol SuperHeroDetailsInteractorDelegate: class {
    func didUpdate(model: SuperHeroDetailsModelType)
}
