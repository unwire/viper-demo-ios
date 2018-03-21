//
//  SuperHeroListModelType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroListModelType {
    var id: Int { get }
    var name: String { get }
    var mightiness: SuperHeroMightness { get }
    var rank: Int { get }
    // ???: If you want to be clean you should, have those encapsulated as an ImageModelType
    var imageUrl: String { get }
    var imageData: Data? { get }
}
