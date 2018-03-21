//
//  AppDelegate.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var environment: EnvironmentType = { Environment() }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = MainUserInterfaceBuilder(environment: environment).currentWindow
        return true
    }
}
