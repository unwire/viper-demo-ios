//
//  SuperHeroListViewModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroListViewModelType: ViewModelType {
    var title: String { get }
    var statusText: String? { get }
    var showLoadingIndicator: Bool { get }
    var options: [String] { get }
    var selectedOption: Int { get }
}
