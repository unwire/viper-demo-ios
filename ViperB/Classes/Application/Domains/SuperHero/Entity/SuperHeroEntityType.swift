//
//  HeroEntityType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Defines super hero entiry interface.
protocol SuperHeroEntityType {
    var id: Int { get }
    var name: String { get }
    var imageUrl: String { get }
    var mainSuperPower: String { get }
    var punchQuote: String { get }
    var mightiness: Int { get }
    var rank: Int { get }
    var bio: String { get }
}
