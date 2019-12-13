//
//  InvestimentFormPresenter.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentFormPresenterProtocol: AnyObject {
    func showError()
    func toggleLoading(_ bool:Bool)
}

class InvestimentFormPresenter: InvestimentFormPresenterProtocol {
    
    weak var investimentFormViewControllerDelegate: InvestimentFormViewControllerProtocol?
    
    func showError() {
        self.investimentFormViewControllerDelegate?.showError()
    }
    
    func toggleLoading(_ bool: Bool) {
        self.investimentFormViewControllerDelegate?.toggleLoading(bool)
    }
}
