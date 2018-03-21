//
//  SuperHeroDetailsViewModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroDetailsViewModelType: ViewModelType {
    var viewTitle: String { get }
    var heroName: String { get }
    var imageData: Data? { get }
    var tagline: String { get }
    var mainSuperPowerLabel: String { get }
    var mainSuperPowerText: String { get }
    var rankLabel: String { get }
    var rankText: String { get }
    var mightinessLabel: String { get }
    var mightinessText: String { get }
    var descriptionText: String { get }
    var isLoading: Bool { get }
    var errorText: String { get }
}
