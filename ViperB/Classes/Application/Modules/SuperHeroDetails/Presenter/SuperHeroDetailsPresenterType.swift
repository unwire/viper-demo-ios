//
//  SuperHeroDetailsPresenterType.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation


protocol SuperHeroDetailsPresenterDelegate: class {
    func didUpdate(viewModel: SuperHeroDetailsViewModelType)
}

protocol SuperHeroDetailsPresenterType: PresenterType {
    func didTapClose()
}
