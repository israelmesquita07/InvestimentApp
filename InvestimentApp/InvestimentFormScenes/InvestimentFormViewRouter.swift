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
            let vc = InvestimentDetailsViewController.createWith(injection: investiment)
            if let currentVC = self.viewControllerDelegate as? UIViewController {
                currentVC.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
//        DispatchQueue.main.async { [weak self] in
//        if var detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InvestimentDetailsViewController") as? InvestimentDetailsViewController {
            
//                guard let self = self else { return }
//                detailsViewController = InvestimentDetailsViewController.init(investiments: investiment)
//                if let vc = self.viewControllerDelegate as? UIViewController {
//                    vc.navigationController?.pushViewController(detailsViewController, animated: true)
//                }
//            }
//        }
    }
}
