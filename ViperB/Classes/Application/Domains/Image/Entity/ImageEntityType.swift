//
//  ImageEntityType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol ImageEntityType {
    var urlString: String { get }
    var data: Data { get }
}
