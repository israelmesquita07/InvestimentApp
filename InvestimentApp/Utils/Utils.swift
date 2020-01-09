//
//  Utils.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

//MARK: - Date Formatter
struct Utils {
    
    static func stringToDate(from string: String) -> Date? {
        let dateFormatter = Utils.dateFormatter()
        guard let date = dateFormatter.date(from: string) else { return nil }
        return date
    }
    
    static func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter
    }
    
    static func dateToString(from date: Date) -> String {
        let dateFormatter = Utils.dateFormatter()
        return dateFormatter.string(from: date)
    }
    
    static func dateStringForServer(stringDate: String) -> String {
        guard let date = Utils.stringToDate(from: stringDate) else { return "" }
        return Utils.dateToStringForServer(from: date)
    }
    
    static func dateToStringForServer(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    static func stringDateFormatterFromServer(from string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        guard let date = dateFormatter.date(from: string) else {
            return "Sem data"
        }
        return Utils.dateToString(from: date)
    }
}


//MARK: - Money
extension Utils {
    
    static func toBraziliansMoney(_ double: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        guard let real = formatter.string(from: NSNumber(value: double)) else {
            return "Sem Valor"
        }
        return real
    }
    
    static func withRatePercentSymbol(_ double: Double) -> String {
        return "\(double)%"
    }
}

//MARK: - Alert
extension Utils {
    
    static func showAlert(delegate:UIViewController, title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        delegate.present(alert, animated: true, completion: nil)
    }
}
