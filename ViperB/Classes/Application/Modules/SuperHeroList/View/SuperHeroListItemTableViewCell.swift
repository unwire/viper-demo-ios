//
//  SuperHeroListItemtableViewCell.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 19/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit

class SuperHeroListItemTableViewCell: UITableViewCell {
    let rankLabel: UILabel

    required init(reuseIdentifier: String) {
        rankLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
        rankLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 24)
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        guard let imv = imageView else { return }
        imv.layer.borderWidth = 1
        imv.layer.borderColor = UIColor.lightGray.cgColor
        imv.contentMode = .scaleAspectFill
        preservesSuperviewLayoutMargins = false
        separatorInset = .zero
        layoutMargins = .zero
        textLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 20)
        detailTextLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 18)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        let oldImageSize = imageView?.bounds.size
        super.layoutSubviews()
        guard let imv = imageView else { return }
        let H = contentView.bounds.size.height
        let W = contentView.bounds.size.width
        let x = CGFloat(10)
        let y = x
        let h = H - (2.0 * y)
        let w = h
        let imF = CGRect(x: x, y: y, width: w, height: h)
        imv.frame = imF
        textLabel?.frame = CGRect(x: imF.maxX + 10, y: H / 2.0 - 20, width: W - imF.maxX - 20, height: 20)
        detailTextLabel?.frame = CGRect(x: imF.maxX + 10, y: H / 2.0 + 5, width: W - imF.maxX - 20, height: 20)
        let newImageSize = frame.size
        guard newImageSize != oldImageSize else { return }
        imv.setRounded()
    }

    func update(with viewModel: SuperHeroListItemViewModelType) {
        self.textLabel?.text = viewModel.title
        self.detailTextLabel?.text = viewModel.subtitle
        rankLabel.text = viewModel.rankText
        accessoryView = viewModel.showRank ? rankLabel : nil
        let imageData = viewModel.imageData
        let image = imageData != nil ? UIImage(data: imageData!) : nil
        self.imageView?.image = image
    }
}
