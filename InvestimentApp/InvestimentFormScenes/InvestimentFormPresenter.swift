//
//  InvestimentFormPresenter.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentFormPresentationLogic: AnyObject {
    func showError()
    func toggleLoading(_ bool: Bool)
}

class InvestimentFormPresenter: InvestimentFormPresentationLogic {

    weak var investimentFormViewControllerDelegate: InvestimentFormDisplayLogic?

    func showError() {
        self.investimentFormViewControllerDelegate?.toggleLoading(false)
        self.investimentFormViewControllerDelegate?.showError()
    }

    func toggleLoading(_ bool: Bool) {
        self.investimentFormViewControllerDelegate?.toggleLoading(bool)
    }
}
