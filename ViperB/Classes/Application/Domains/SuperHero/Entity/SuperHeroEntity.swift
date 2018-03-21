//
//  SuperHeroEntity.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Implements default super-hero entity.
struct SuperHeroEntity: SuperHeroEntityType {
    let id: Int
    let name: String
    let punchQuote: String
    let mainSuperPower: String
    let imageUrl: String
    let mightiness: Int
    let rank: Int
    var bio: String
}
