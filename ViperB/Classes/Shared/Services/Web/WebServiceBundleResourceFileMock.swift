//
//  WebServiceBundleResourceFileMock.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


class WebServiceBundleResourceFileMock: WebServiceType {

    var delay: TimeInterval = 2

    func getData(urlString: String, completion complete: @escaping (WebServiceTypeDataResult) -> Void) {
        guard let url = Bundle.main.url(forResource: urlString, withExtension: nil) else {
            complete(.failure(.invalidUrl))
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard let data = try? Data(contentsOf: url) else {
                complete(.failure(.noData))
                return
            }
            complete(.success(data))
        }
    }
}
