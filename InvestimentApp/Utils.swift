//
//  Utils.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

struct Utils {
    
    static func dateStringForServer(stringDate: String) -> String {
        guard let date = Utils.stringToDate(from: stringDate) else { return "" }
        return Utils.dateToString(from: date)
    }
    
    static func stringToDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        guard let date = dateFormatter.date(from: string) else { return nil }
        return date
    }

    static func dateToString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
