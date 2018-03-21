//
//  SuperHeroDetailsViewModelType+SuperHeroDetailsModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation

extension SuperHeroDetailsViewModel {
    init(model: SuperHeroDetailsModelType?,
         isLoading: Bool, error: Error? = nil) {

        self.viewTitle = "Hero details"
        self.mainSuperPowerLabel = "Main superpower"
        self.rankLabel = "Rank: "
        self.mightinessLabel = "Mightiness:"
        self.isLoading = isLoading
        
        self.heroName = model?.name ?? ""
        self.imageData  = model?.imageData
        self.tagline = model?.punchQuote ?? ""
        self.mainSuperPowerText = model?.mainSuperPower ?? ""
        self.rankText = model?.rank.rankString() ?? ""
        self.mightinessText = model?.mightiness.longDescription ?? ""
        self.descriptionText = model?.bio ?? ""
        self.errorText = error?.localizedDescription ?? ""
    }
}


fileprivate extension Int {
    func rankString() -> String {
        switch self {
        case 0:
            return "unknown"
        case 1:
            return "first!"
        case 2:
            return "second"
        case 3:
            return "third"
        default:
            return "\(self)th"
        }
    }
}
