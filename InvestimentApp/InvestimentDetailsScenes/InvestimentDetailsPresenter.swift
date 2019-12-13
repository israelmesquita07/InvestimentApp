//
//  InvestimentDetailsPresenter.swift
//  InvestimentApp
//
//  Created by Israel on 11/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentDetailsPresenterProtocol: AnyObject {
    func showInvestiments(investiment: Investiment)
}

class InvestimentDetailsPresenter: InvestimentDetailsPresenterProtocol {
    
    weak var investimentDetailViewControllerDelegate: InvestimentDetailsViewControllerProtocol?
    
    func showInvestiments(investiment: Investiment) {
//        self.investimentFormViewControllerDelegate?.showInvestiments(investiments: investiment)
    }
}
