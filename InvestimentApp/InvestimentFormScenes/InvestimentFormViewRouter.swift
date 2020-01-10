//
//  InvestimentFormViewRouter.swift
//  InvestimentApp
//
//  Created by Israel on 07/01/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

protocol InvestimentFormRoutingLogic: AnyObject {
    func routeToInvestiments(investiment: Investiment)
}

class InvestimentFormViewRouter: InvestimentFormRoutingLogic {

    weak var viewControllerDelegate: InvestimentFormDisplayLogic?

    func routeToInvestiments(investiment: Investiment) {

        DispatchQueue.main.async {
            guard let vcInvestiment = InvestimentDetailsViewController.instantiate(withInjection: investiment) else {
                return
            }
            if let currentVC = self.viewControllerDelegate {
                currentVC.navigationController?.pushViewController(vcInvestiment, animated: true)
            }
        }
    }
}
