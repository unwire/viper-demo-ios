//
//  SuperHeroListModel+SuperHeroEntityType+ImageEntityType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


extension SuperHeroListModel {
    init(hero: SuperHeroEntityType, image: ImageEntityType?) {
        self.id = hero.id
        self.name = hero.name
        self.mightiness = SuperHeroMightness(fromNumber: hero.mightiness)
        self.rank = hero.rank
        self.imageData = image?.data
        self.imageUrl = hero.imageUrl
    }
}
