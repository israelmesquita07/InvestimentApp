//
//  InvestimentFormInteractor.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentFormBusinessLogic {
    func getInvestiments(params: [String: Any])
}

class InvestimentFormInteractor: InvestimentFormBusinessLogic {

    weak var investimentFormPresenterDelegate: InvestimentFormPresentationLogic?
    weak var investimentFormRouterDelegate: InvestimentFormRoutingLogic?

    func getInvestiments(params: [String: Any]) {
        if !params.isEmpty {
            investimentFormPresenterDelegate?.toggleLoading(true)
            let worker = InvestimentFormWorker()

            worker.getInvestiments(params: params, onComplete: { [weak self] (investiment) in
                guard let self = self else { return }
                self.investimentFormRouterDelegate?.routeToInvestiments(investiment: investiment)
                self.investimentFormPresenterDelegate?.toggleLoading(true)
                }, onError: { [weak self] _ in
                    guard let self = self else { return }
                    self.investimentFormPresenterDelegate?.showError()
            })
        }
    }
}
