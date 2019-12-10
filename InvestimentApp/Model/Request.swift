//
//  Request.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

struct Request {
    var investedAmount: Double
    var index: String
    var rate: Int
    var isTaxFree: Bool
    var maturityDate: String
    var params: [String: Any] {
        return [
                "investedAmount" : investedAmount,
                "index" : index,
                "rate" : rate,
                "isTaxFree" : isTaxFree,
                "maturityDate" : maturityDate
                ]
    }
}
