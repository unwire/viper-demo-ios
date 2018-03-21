//
//  SuperHeroDetailsViewModel.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


struct SuperHeroDetailsViewModel: SuperHeroDetailsViewModelType {
    let viewTitle: String
    let heroName: String
    let imageData: Data?
    let tagline: String
    let mainSuperPowerLabel: String
    let mainSuperPowerText: String
    let rankLabel: String
    let rankText: String
    let mightinessLabel: String
    let mightinessText: String
    let descriptionText: String
    var isLoading: Bool
    let errorText: String
}
