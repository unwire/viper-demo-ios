//
//  ImageServiceType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum ImageServiceError: Error {
    case invalidUrl
    case noImageData
    case invalidImageData
    case networkError(Error)
}

typealias ImageServiceTypeResult = Result<ImageEntityType, ImageServiceError>

protocol ImageServiceType {
    func loadImage(urlString: String, completion: @escaping (ImageServiceTypeResult) -> Void)
}
