//
//  SuperHeroMightness.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum SuperHeroMightness {
    case unknown
    case noob   // not mighty at all
    case mighty // somehow mighty
    case badass // badass mighty
    case batman // The mightiest - as only Batman can be!
}

extension SuperHeroMightness {
    init(fromNumber number: Int) {
        switch number {
        case 0...3:
            self = .noob
        case 4...6:
            self = .mighty
        case 7...9:
            self = .badass
        case 10:
            self = .batman
        default:
            self = .unknown
        }
    }
}

extension SuperHeroMightness {
    var shortDescription: String {
        switch self {
        case .noob:
            return "noob"
        case .mighty:
            return "mighty"
        case .badass:
            return "badass"
        case .batman:
            return "Mighty as Batman!"
        default:
            return "unknown"
        }
    }

    var longDescription: String {
        switch self {
        case .noob:
            return "He is such a noob!"
        case .mighty:
            return "Quite mightly, I say!"
        case .badass:
            return "Bad-ass hero"
        case .batman:
            return "Badass Mighty Batman!"
        default:
            return "Not sure if mighty at all"
        }
    }
}
