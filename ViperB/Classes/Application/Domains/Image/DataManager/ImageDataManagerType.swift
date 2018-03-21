//
//  ImageDataManagerType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation

enum ImageDataManagerError: Error {
    case invalidUrl
    case noImageData
    case invalidImageData
    case networkError(Error)
}

typealias ImageDataManagerTypeResult = Result<ImageEntityType, ImageDataManagerError>

protocol ImageDataManagerType: class {

    func image(for urlString: String) -> ImageEntityType?

    func loadImage(for urlString: String, completion: @escaping (ImageDataManagerTypeResult) -> Void)
}
