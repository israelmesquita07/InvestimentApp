//
//  Constants.swift
//  InvestimentApp
//
//  Created by Israel on 09/01/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: - InvestmentFormView
    static let kInvestedAmountLabel = "Quanto você gostaria de aplicar? *"
    static let kInvestedAmountTextField = "Campo de texto para o quanto você gostaria de aplicar."
    static let kMaturityDateLabel = "Qual a data de vencimento do investimento? *"
    static let kMaturityDateTextField = "Campo de texto para a data de vencimento do investimento."
    static let kInvestmentCDIRateLabel = "Qual o percentual do CDI do investimento? *"
    static let kInvestmentCDIRateTextField = "Campo de texto para o percentual do CDI do investimento."
    static let kSimulateButton = "Simular"
    // MARK: - InvestmentDetailsView
    static let kInvestmentResultLabel = "Resultado da simulação"
    static let kProfitabilityLabel = "Rendimento total de "
    // MARK: - SimulateAgainView
    static let kSimulateAgainButton = "Simular novamente"
    // MARK: - InvestmentDetailTableViewCell
    static let kInvestedAmount = "Valor aplicado inicialmente"
    static let kGrossAmount = "Valor bruto do investimento"
    static let kGrossAmountProfit = "Valor do rendimento"
    static let kTaxesAmount = "IR sobre o investimento"
    static let kNetAmount = "Valor líquido do investimento"
    static let kMaturityDate = "Data de resgate"
    static let kMaturityTotalDays = "Dias corridos"
    static let kMonthlyGrossRateProfit = "Rendimento mensal"
    static let kRate = "Percentual do CDI do investimento"
    static let kAnnualNetRateProfit = "Rentabilidade anual"
    static let kAnnualGrossRateProfit = "Rentabilidade no período"
}
