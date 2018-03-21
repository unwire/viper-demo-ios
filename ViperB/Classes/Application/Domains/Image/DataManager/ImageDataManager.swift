//
//  ImageDataManager.swift
//  
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//

import Foundation
import UIKit

class ImageDataManager: ImageDataManagerType {

    let webService: WebServiceType
    let storage: ImageStorageType

    init(webService: WebServiceType, storage: ImageStorageType) {
        self.webService = webService
        self.storage = storage
    }
    
    func image(for urlString: String) -> ImageEntityType? {
        guard let data = storage.loadImage(urlString: urlString) else { return nil }
        return ImageEntity(urlString: urlString, data: data as Data)
    }

    func loadImage(for urlString: String, completion complete: @escaping (ImageDataManagerTypeResult) -> Void) {
        webService.getData(urlString: urlString) { [weak self] result  in
            switch result {
            case .success(let data):
                self?.storage.saveImage(urlString: urlString, imageData: data)
                complete(.success(ImageEntity(urlString: urlString, data: data as Data)))
            case .failure(_):
                complete(.failure(.noImageData))
            }
        }
    }
}


