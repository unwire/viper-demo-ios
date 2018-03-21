//
//  RouterType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


/// Describes router component in a VIPER architecture.
protocol RouterType: class {
    /// The reference to the view which the router should use
    /// as a starting point for navigation. Injected by the builder.
    weak var baseView: UIViewController? { get set }
}
