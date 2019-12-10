//
//  Investiment.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

struct Investiment: Decodable {
    let investmentParameter: InvestmentParameter?
    let grossAmount: Double?
    let taxesAmount: Double?
    let netAmount: Double?
    let grossAmountProfit: Double?
    let netAmountProfit: Double?
    let annualGrossRateProfit: Double?
    let monthlyGrossRateProfit: Double?
    let dailyGrossRateProfit: Double?
    let taxesRate: Double?
    let rateProfit: Double?
    let annualNetRateProfit: Double?
}

struct InvestmentParameter: Decodable {
    let investedAmount: Double?
    let yearlyInterestRate: Double?
    let maturityTotalDays: Int?
    let maturityBusinessDays: Int?
    let maturityDate: String?
    let rate: Double?
    let isTaxFree: Bool?
}
