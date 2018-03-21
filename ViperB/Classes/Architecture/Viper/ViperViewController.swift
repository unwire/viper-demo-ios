//
//  ViperViewController.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 07/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


/// Viper view controller base class.
class ViperViewController<P: PresenterType>: UIViewController, ViewType {

    let presenter: P

    init(presenter: P) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }


    // MARK: View life cycle

    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillBecomeActive()
    }

    override func viewDidDisappear(_ animated: Bool) {
        presenter.viewDidBecomeInactive()
    }


    // MARK: - Invalid initializer

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
