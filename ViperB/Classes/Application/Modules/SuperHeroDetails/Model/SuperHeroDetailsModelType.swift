//
//  SuperHeroDetailsModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroDetailsModelType {
    var name: String { get }
    var imageUrl: String { get }
    var imageData: Data? { get }
    var punchQuote: String { get }
    var mainSuperPower: String { get }
    var rank: Int { get }
    var mightiness: SuperHeroMightness { get }
    var bio: String { get }
}
