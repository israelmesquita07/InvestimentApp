//
//  Double+Extension.swift
//  InvestimentApp
//
//  Created by Israel on 11/01/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation

extension Double {
    func toRealCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.numberStyle = .currency
        guard let formattedTipAmount = formatter.string(from: self as NSNumber) else {
            return ""
        }
        return formattedTipAmount
    }
}
