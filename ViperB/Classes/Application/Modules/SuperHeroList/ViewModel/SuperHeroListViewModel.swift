//
//  SuperHeroListViewModel.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


struct SuperHeroListViewModel: SuperHeroListViewModelType {
    let title: String
    let statusText: String?
    let showLoadingIndicator: Bool
    let options: [String]
    let selectedOption: Int
}
