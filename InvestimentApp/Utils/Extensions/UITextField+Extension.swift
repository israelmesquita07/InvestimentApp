//
//  UITextField+Extension.swift
//  InvestimentApp
//
//  Created by Israel on 11/01/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

extension UITextField {

    public func toCurrency() {
        guard let text = self.text else { return }
        let centsNumber = text.compactMap { char in
            return Double(char.description)
            }.reduce(0, {($0 * 10) + $1})
        let number: Double = Double(centsNumber) / 100
        self.text = number.toRealCurrency()
    }

    public func removeFormatAmount() -> Double? {
        if let text = self.text {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.numberStyle = .currency
            formatter.currencySymbol = "R$"
            formatter.decimalSeparator = ","
            if let convertedNumber = formatter.number(from: text) {
                return Double(truncating: convertedNumber)
            }
            return nil
        }
        return nil
    }

    public func toPercent() {
        let text = preparePercent()
        self.text = text + "%"
    }

    public func toNoPercent() {
        self.text = preparePercent()
    }

    private func preparePercent() -> String {
        guard var text = self.text else { return ""}
        text = text.replacingOccurrences(of: "%", with: "")
        return text
    }
}
