//
//  SuperHeroDetailsInteractorMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 21/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroDetailsInteractorMock: SuperHeroDetailsInteractorType {
    var failedError: SuperHeroDetailsInteractorError?
    private(set) var loadSuperHeroDetailsCalled: Bool?
    var model: SuperHeroDetailsModelType {
        return SuperHeroDetailsModel(name: "name",
                                     imageUrl: "https://imageUrl",
                                     imageData: nil,
                                     punchQuote: "punchQuote",
                                     mainSuperPower: "mainSuperPower",
                                     rank: 1,
                                     mightiness: .noob,
                                     bio: "bio")
    }
    func loadSuperHeroDetails(completion: @escaping (Result<SuperHeroDetailsModelType, SuperHeroDetailsInteractorError>) -> Void) {
        loadSuperHeroDetailsCalled = true
        guard failedError == nil else {
            completion(.failure(failedError!))
            return
        }
        completion(.success(self.model))
    }
}
