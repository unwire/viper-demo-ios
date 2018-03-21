//
//  SuperHeroListModel.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


struct SuperHeroListModel: SuperHeroListModelType {
    let id: Int
    let name: String
    let mightiness: SuperHeroMightness
    let rank: Int
    let imageUrl: String
    let imageData: Data?
}

extension SuperHeroListModel {
    init(model: SuperHeroListModelType, imageData: Data?) {
        self.id = model.id
        self.name = model.name
        self.mightiness = model.mightiness
        self.rank = model.rank
        self.imageData = imageData
        self.imageUrl = model.imageUrl
    }
}
