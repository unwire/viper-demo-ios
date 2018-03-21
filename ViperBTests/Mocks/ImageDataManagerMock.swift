//
//  ImageDataManagerMock.swift
//  ViperBTests
//
//  Created by Hossein Asgari Seresht on 20/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
@testable import ViperB

class ImageDataManagerMock: ImageDataManagerType {
    var failedLoadImageError: ImageDataManagerError?
    var cachedImage: Bool?
    
    func image(for urlString: String) -> ImageEntityType? {
        guard cachedImage == true else {
            return nil
        }
        return ImageEntity(urlString: urlString, data: Data())
    }

    func loadImage(for urlString: String, completion: @escaping (ImageDataManagerTypeResult) -> Void) {
        guard failedLoadImageError == nil else {
            completion(.failure(failedLoadImageError!))
            return
        }
        completion(.success(ImageEntity(urlString: urlString, data: Data())))
    }
}
