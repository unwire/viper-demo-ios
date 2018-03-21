//
//  UIImageView+Eclipse.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func setRounded() {
        self.layer.masksToBounds = true
        clipsToBounds = true
        let size = self.bounds.size
        let radius = min(size.width, size.height) / 2.0
        self.layer.cornerRadius = radius
    }
}
