//
//  SuperHeroListItemViewModel+SuperHeroListModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


extension SuperHeroListItemViewModel {
    init(model: SuperHeroListModelType, rankText: String, showRank: Bool) {
        self.title = model.name
        self.subtitle = model.mightiness.shortDescription
        self.imageData = model.imageData
        self.rankText = rankText
        self.showRank = showRank
    }
}

