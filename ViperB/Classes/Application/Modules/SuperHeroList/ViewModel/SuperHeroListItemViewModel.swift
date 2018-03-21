//
//  SuperHeroListItemViewModel.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


struct SuperHeroListItemViewModel: SuperHeroListItemViewModelType {
    let title: String
    let subtitle: String
    let imageData: Data?
    let rankText: String
    let showRank: Bool
}
