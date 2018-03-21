//
//  ImageService.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


class ImageService: ImageServiceType {

    let webService: WebServiceType

    init(webService: WebServiceType) {
        self.webService = webService
    }

    func loadImage(urlString: String, completion complete: @escaping (ImageServiceTypeResult) -> Void) {
        webService.getData(urlString: urlString) { result in
            switch result {
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    complete(.failure(.invalidUrl))
                case .noData:
                    complete(.failure(.noImageData))
                case .networkError(let error):
                    complete(.failure(.networkError(error)))
                case .jsonParseError:
                    complete(.failure(.invalidImageData))
                }
            case .success(let data):
                guard let _ = UIImage(data: data) else {
                    complete(.failure(.invalidImageData))
                    return
                }
                let entity = ImageEntity(urlString: urlString, data: data)
                complete(.success(entity))
            }
        }
    }
}
