//
//  SuperHeroDataManagerMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroDataManagerMock: SuperHeroDataManagerType {
    var failedToLoad: Bool? = false
    
    func load(completion: @escaping (SuperHeroDataManagerTypeResult) -> Void) {
        guard failedToLoad == false else {
            completion(.failure(.loadError))
            return
        }
        completion(.success(mockSuperHeroEntityTypes()))
    }

    // MARK: Helpers

    private func mockSuperHeroEntityTypes() -> [SuperHeroEntityType] {
        var result: [SuperHeroEntityType] = []
        for i in 1...100 {
            let entity = SuperHeroEntity(id: i,
                                         name: "name \(i)",
                                         punchQuote: "punchQuote \(i)",
                                         mainSuperPower: "mainSuperPower \(i)",
                                         imageUrl: "https://imageUrl/\(i)",
                                         mightiness: i,
                                         rank: i,
                                         bio: "bio \(i)")
            result.append(entity)
        }
        // suffling array
        return result.sorted(by: { _,_ in arc4random() % 2 == 0 })
    }
}
