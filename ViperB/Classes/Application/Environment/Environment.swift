//
//  Environment.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


class Environment: EnvironmentType {

    let loadUrlString = "heroes.json"
    let webServiceMock = WebServiceBundleResourceFileMock()
    let webService = WebService()

    //let loadUrlString = "https://gateway.marvel.com:443/v1/public/characters"
    //let webService: WebServiceType = WebService(publicKey: "0c7d61f4c01a4e555ada568a4280ecfc", privateKey: "0ca4312fcaec60712cf84751847e253fe3d401c4")

    lazy var superHeroDataManager: SuperHeroDataManagerType = {
        let heroService = SuperHeroService(webService: webServiceMock, loadUrlString: loadUrlString)
        let heroStorage = SuperHeroStorage()
        let heroDataManager = SuperHeroDataManager(service: heroService, storage: heroStorage)
        return heroDataManager
    }()

    lazy var imageDataManager: ImageDataManagerType = { return ImageDataManager(webService: webService, storage: ImageStorage()) }()


    // MARK: Private

}
