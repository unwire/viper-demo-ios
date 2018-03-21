//
//  BuilderType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


/// Describes builder component in a VIPER architecture.
protocol BuilderType {
    func build() -> UIViewController
}
