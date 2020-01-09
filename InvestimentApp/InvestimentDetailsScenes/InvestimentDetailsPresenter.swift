//
//  InvestimentDetailsPresenter.swift
//  InvestimentApp
//
//  Created by Israel on 11/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

protocol InvestimentDetailsPresenterProtocol: AnyObject {
    func brMoney(_ double:Double) -> String
    func percentSymbol(_ double: Double) -> String
    func strDateFromAPI(from string: String) -> String
}

class InvestimentDetailsPresenter: InvestimentDetailsPresenterProtocol {
    
    weak var investimentDetailViewControllerDelegate: InvestimentDetailsViewControllerProtocol?
    
    func brMoney(_ double:Double) -> String {
        return Utils.toBraziliansMoney(double)
    }
    
    func percentSymbol(_ double: Double) -> String {
        return Utils.withRatePercentSymbol(double)
    }
    
    func strDateFromAPI(from string: String) -> String {
        Utils.stringDateFormatterFromServer(from: string)
    }
}
