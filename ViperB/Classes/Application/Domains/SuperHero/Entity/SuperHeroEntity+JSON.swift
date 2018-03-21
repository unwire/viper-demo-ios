//
//  SuperHeroEntity+Json.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum SuperHeroEntityKeys: String {
    case id = "id"
    case name = "name"
    case imageUrl = "imageUrl"
    case mainSuperPower = "mainSuperPower"
    case punchQuote = "punchQuote"
    case mightiness = "mightiness"
    case rank = "rank"
    case bio = "bio"
}


/// Adds initializer from json object.
extension SuperHeroEntity: JsonDeserializable {
    init(json: Json) throws {
        self.id             = try json.jsonValue(SuperHeroEntityKeys.id.rawValue)
        self.name           = try json.jsonValue(SuperHeroEntityKeys.name.rawValue)
        self.imageUrl       = try json.jsonValue(SuperHeroEntityKeys.imageUrl.rawValue)
        self.mainSuperPower = try json.jsonValue(SuperHeroEntityKeys.mainSuperPower.rawValue)
        self.punchQuote     = try json.jsonValue(SuperHeroEntityKeys.punchQuote.rawValue)
        self.mightiness     = try json.jsonValue(SuperHeroEntityKeys.mightiness.rawValue)
        self.rank           = try json.jsonValue(SuperHeroEntityKeys.rank.rawValue)
        self.bio            = try json.jsonValue(SuperHeroEntityKeys.bio.rawValue)
    }
}
