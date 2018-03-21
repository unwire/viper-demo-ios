//
//  MainUserInterfaceBuilder.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 08/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit

class MainUserInterfaceBuilder: EnvironmentConsumer, BuilderType {

    lazy var currentWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = build()
        window.makeKeyAndVisible()
        return window
    }()

    func build() -> UIViewController {
        let svc = SuperHeroListBuilder(environment: environment).build()
        let navigationController = UINavigationController(rootViewController: svc)
        return navigationController
    }
}
