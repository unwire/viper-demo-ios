//
//  SuperHeroListItemViewModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroListItemViewModelType {
    var title: String { get }
    var subtitle: String { get }
    var rankText: String { get }
    var showRank: Bool { get }
    var imageData: Data? { get }
}
