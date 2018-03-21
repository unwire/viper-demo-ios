//
//  Result.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


enum Result<S: Any, E: Error> {
    case success(_: S)
    case failure(_: E)
}
