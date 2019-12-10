//
//  InvestimentFormViewController.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

class InvestimentFormViewController: UIViewController {

    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var percentTextField: UITextField!
    @IBOutlet weak var simulateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simulateButton.isEnabled = false
    }
    
    private func setup() {
        moneyTextField.delegate = self
        dateTextField.delegate = self
        percentTextField.delegate = self
    }
    
    @IBAction func simulateInvestiment(_ sender: UIButton) {
        
    }
    
}

//MARK: - UITextFieldDelegate
extension InvestimentFormViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if moneyTextField.hasText, dateTextField.hasText, percentTextField.hasText {
            simulateButton.backgroundColor = UIColor(displayP3Red: 90, green: 197, blue: 179, alpha: 1.0)
            simulateButton.isEnabled = true
        }
    }
}
