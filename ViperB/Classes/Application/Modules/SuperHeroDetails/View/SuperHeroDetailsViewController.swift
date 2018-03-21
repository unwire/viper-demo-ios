//
//  SuperHeroDetailsViewController.swift
//  ViperB
//
//  Created by Lukasz Marcin Margielewski on 09/03/2018.
//  Copyright © 2018 Unwire Aps. All rights reserved.
//

import Foundation
import UIKit


class SuperHeroDetailsViewController<P: SuperHeroDetailsPresenterType>: ViperViewController<P> {

    @IBOutlet      var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var mainSuperPowerLabel: UILabel!
    @IBOutlet weak var mainSuperPowerTextLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankTextLabel: UILabel!
    @IBOutlet weak var mightnessLabel: UILabel!
    @IBOutlet weak var mightnessTextLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isLoadingIndicator: UIActivityIndicatorView!

    override func loadView() {
        Bundle.main.loadNibNamed("SuperHeroDetailsViewController", owner: self, options: nil)
        view = UIScrollView()
        view.isOpaque = true
        view.backgroundColor = .white
        contentView.frame = view.bounds
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(contentView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
    }

    override func viewDidLayoutSubviews() {
        guard let sc = view as? UIScrollView else { return }
        let W = sc.bounds.width
        let maxFrame = CGRect(x: 0, y: 40, width: W, height: 10000)
        contentView.frame = maxFrame
        contentView.updateConstraints()
        contentView.layoutIfNeeded()
        imageView.setRounded()
        let maxY = descriptionLabel.frame.maxY
        sc.contentSize = CGSize(width: W, height: maxY + 40)
    }

    // MARK: Private

    @objc private func close() {
        presenter.didTapClose()
    }
}


// MARK: SuperHeroDetailsPresenterDelegate

extension SuperHeroDetailsViewController: SuperHeroDetailsPresenterDelegate {
    func didUpdate(viewModel: SuperHeroDetailsViewModelType) {
        DispatchQueue.main.async { [weak self] in
            guard let wSelf = self else { return }
            wSelf.title = viewModel.viewTitle
            wSelf.imageView.image = viewModel.imageData != nil ?  UIImage(data: viewModel.imageData!) : nil
            wSelf.heroNameLabel.text = viewModel.heroName
            wSelf.taglineLabel.text = viewModel.tagline
            wSelf.mainSuperPowerLabel.text = viewModel.mainSuperPowerLabel
            wSelf.mainSuperPowerTextLabel.text = viewModel.mainSuperPowerText
            wSelf.rankLabel.text = viewModel.rankLabel
            wSelf.rankTextLabel.text = viewModel.rankText
            wSelf.mightnessLabel.text = viewModel.mightinessLabel
            wSelf.mightnessTextLabel.text = viewModel.mightinessText
            wSelf.descriptionLabel.text = viewModel.descriptionText
            viewModel.isLoading ? wSelf.isLoadingIndicator.startAnimating() : wSelf.isLoadingIndicator.stopAnimating()
        }
    }
}
