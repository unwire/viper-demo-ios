//
//  SuperHeroDetailsModel+SuperHeroEntityType+ImageEntityType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


extension SuperHeroDetailsModel {
    init(entity: SuperHeroEntityType, image: ImageEntityType?) {
        self.name = entity.name
        self.mightiness = SuperHeroMightness(fromNumber: entity.mightiness)
        self.imageData = image?.data
        self.imageUrl = entity.imageUrl
        self.punchQuote = entity.punchQuote
        self.rank = entity.rank
        self.bio = entity.bio
        self.mainSuperPower = entity.mainSuperPower
    }
}
