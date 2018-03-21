//
//  PresenterType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


/// Describes presenter component in a VIPER architecture.
protocol PresenterType: class {
    /// Informs presenter that the view will become active.
    func viewWillBecomeActive()

    /// Informs presenter that the view just became inactive.
    func viewDidBecomeInactive()
}

/// Optional methods related to view state.
extension PresenterType {
    func viewDidBecomeInactive() {}
}
