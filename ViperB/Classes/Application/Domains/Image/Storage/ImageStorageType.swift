//
//  ImageStorageType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation

/// Defines interface for storing image data.
protocol ImageStorageType {
    func loadImage(urlString: String) -> Data?
    func saveImage(urlString: String, imageData: Data)
}
