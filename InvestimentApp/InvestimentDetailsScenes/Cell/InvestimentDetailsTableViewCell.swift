//
//  InvestimentDetailsTableViewCell.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

class InvestimentDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contextualLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(contextual:String, value:String){
        contextualLabel.text = contextual
        valueLabel.text = value
    }
    
}
