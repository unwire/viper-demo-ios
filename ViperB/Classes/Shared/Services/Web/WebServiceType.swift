//
//  WebServiceType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum WebServiceError: Error {
    case invalidUrl
    case noData
    case networkError(Error)
    case jsonParseError
}


typealias WebServiceTypeDataResult = Result<Data, WebServiceError>
typealias WebServiceTypeJsonResult = Result<Json, WebServiceError>

protocol WebServiceType {
    func getData(urlString: String, completion: @escaping (WebServiceTypeDataResult) -> Void)
    func getJson(urlString: String, completion: @escaping (WebServiceTypeJsonResult) -> Void)
}


extension WebServiceType {
    func getJson(urlString: String, completion complete: @escaping (WebServiceTypeJsonResult) -> Void) {
        getData(urlString: urlString) { result in
            switch result {
            case .failure(let error):
                complete(.failure(error))
            case .success(let data):
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data), let json = jsonObject as? Json else {
                    complete(.failure(.jsonParseError))
                    return
                }
                complete(.success(json))
            }
        }
    }

}
