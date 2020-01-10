//
//  InvestimentDetailsPresenter.swift
//  InvestimentApp
//
//  Created by Israel on 11/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

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
        let strWithDot = Utils.withRatePercentSymbol(double)
        return strWithDot.replacingOccurrences(of: ".", with: ",").replacingOccurrences(of: ",0", with: "")
    }
    
    func strDateFromAPI(from string: String) -> String {
        Utils.stringDateFormatterFromServer(from: string)
    }
}
