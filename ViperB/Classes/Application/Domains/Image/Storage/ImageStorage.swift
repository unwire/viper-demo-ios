//
//  ImageStorage.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Implements im-memory storage of image data.
/// TODO: Implement real storage (NSCodying or Core Data).
class ImageStorage: ImageStorageType {

    private lazy var cache: NSCache<NSString, NSData> = { NSCache<NSString, NSData>() }()

    func loadImage(urlString: String) -> Data? {
        return cache.object(forKey: urlString as NSString) as Data?
    }

    func saveImage(urlString: String, imageData: Data) {
        cache.setObject(imageData as NSData, forKey: urlString as NSString)
    }
}
