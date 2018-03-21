//
//  SuperHeroService.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


fileprivate let jsonDataKey = "data"
fileprivate let jsonResultsKey = "results"

class SuperHeroService: SuperHeroServiceType {
    let webService: WebServiceType
    let loadUrlString: String

    init(webService: WebServiceType, loadUrlString: String) {
        self.webService = webService
        self.loadUrlString = loadUrlString
    }

    func load(completion complete: @escaping (SuperHeroServiceTypeResult) -> Void) {
        webService.getJson(urlString: loadUrlString) { result in
            switch result {
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    complete(.failure(.invalidUrl))
                case .noData:
                    complete(.failure(.noSuperHeroData))
                case .networkError(let error):
                    complete(.failure(.networkError(error)))
                case .jsonParseError:
                    complete(.failure(.invalidSuperHeroData))
                }
            case .success(let json):
                guard let data = json[jsonDataKey] as? Json, let heroes = data[jsonResultsKey] as? Array<Json> else {
                    complete(.failure(.invalidSuperHeroData))
                    return
                }
                guard let entities = try? heroes.map({ (hero) -> SuperHeroEntity in
                    let entity = try SuperHeroEntity(json: hero)
                    return entity
                }) else {
                    complete(.failure(.invalidSuperHeroData))
                    return
                }
                complete(.success(entities))
            }
        }
    }
}
