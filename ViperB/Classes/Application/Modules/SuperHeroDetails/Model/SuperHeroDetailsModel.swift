//
//  SuperHeroDetailsModel.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


struct SuperHeroDetailsModel: SuperHeroDetailsModelType {
    let name: String
    let imageUrl: String
    let imageData: Data?
    let punchQuote: String
    let mainSuperPower: String
    let rank: Int
    let mightiness: SuperHeroMightness
    let bio: String
}
