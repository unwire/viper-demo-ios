//
//  SuperHeroListInteractorMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class SuperHeroListInteractorMock: SuperHeroListInteractorType {

    private(set) var updatedModel: SuperHeroListModelType?
    private(set) var loadImageCalled: Bool?
    private(set) var loadTop10Called: Bool?
    private(set) var loadAllSortedAlphabeticallyCalled: Bool?
    var failedError: SuperHeroListInteractorError?
    private var models: [SuperHeroListModelType] {
        var result: [SuperHeroListModelType] = []
        for i in 1...100 {
            let model = SuperHeroListModel(id: i,
                                           name: "name \(i)",
                                           mightiness: .noob,
                                           rank: i,
                                           imageUrl: "https://imageUrl/\(i)",
                                           imageData: nil)
             result.append(model)
        }
        return result
    }
    func loadImage(for model: SuperHeroListModelType) {
        loadImageCalled = true
    }

    func loadTop10(completion: @escaping (SuperHeroListInteractorTypeResult) -> Void) {
        loadTop10Called = true
        guard failedError == nil else {
            completion(.failure(failedError!))
            return;
        }
        completion(.success(models))
    }

    func loadAllSortedAlphabetically(completion: @escaping (SuperHeroListInteractorTypeResult) -> Void) {
        loadAllSortedAlphabeticallyCalled = true
        guard failedError == nil else {
            completion(.failure(failedError!))
            return;
        }
        completion(.success(models))
    }
}
