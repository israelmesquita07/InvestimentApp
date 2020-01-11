//
//  InvestimentFormWorker.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import Foundation

class InvestimentFormWorker {

    func getInvestiments(params: [String: Any],
                         onComplete:@escaping(Investiment) -> Void,
                         onError:@escaping(Error?) -> Void) {

        API().getInvestiment(params: params, onComplete: { (investiments) in
            onComplete(investiments)
        }, onError: { (error) in
            onError(error)
        })
    }
}
