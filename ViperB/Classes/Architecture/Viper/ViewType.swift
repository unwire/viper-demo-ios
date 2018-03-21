//
//  ViewType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Describes view component in a VIPER architecture.
protocol ViewType {
    associatedtype P: PresenterType
    /// A presenter
    var presenter: P { get }
}
