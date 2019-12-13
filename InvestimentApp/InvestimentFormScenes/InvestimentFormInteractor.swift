//
//  InvestimentFormInteractor.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentFormInteractorProtocol {
    func getInvestiments(params: [String : Any])
}

class InvestimentFormInteractor: InvestimentFormInteractorProtocol {

    weak var investimentFormPresenterDelegate: InvestimentFormPresenterProtocol?
    weak var investimentDetailPresenterDelegate: InvestimentDetailsPresenterProtocol?

    func getInvestiments(params: [String : Any]) {
        investimentFormPresenterDelegate?.toggleLoading(true)
        let worker = InvestimentFormWorker()
        worker.getInvestiments(params: params, onComplete: { [weak self] (investiment) in
            guard let self = self else { return }
//            self.investimentFormPresenterDelegate?.showInvestiments(investiment: investiment)
        }) { (error) in
            self.investimentFormPresenterDelegate?.showError()
        }
    }
}
