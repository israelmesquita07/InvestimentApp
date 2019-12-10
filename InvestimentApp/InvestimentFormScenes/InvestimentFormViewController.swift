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
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: view.frame.height/3.3)))
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.locale = Locale(identifier: "pt-br")
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var toolbarDatePicker: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateSelected))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleButton, doneButton]
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        simulateButton.isEnabled = false
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbarDatePicker
        dateTextField.delegate = self
        moneyTextField.delegate = self
        percentTextField.delegate = self
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        dateFormatter(datePicker: datePicker)
    }
    
    @objc func doneDateSelected() {
        dateFormatter(datePicker: datePicker)
        view.endEditing(true)
    }
    
    private func dateFormatter(datePicker: UIDatePicker) {
        //mandar pro presenter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: datePicker.date)
        dateTextField.text = formattedDate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func simulateInvestiment(_ sender: UIButton) {
        //chamar interactor
    }
    
}

//MARK: - UITextFieldDelegate
extension InvestimentFormViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if moneyTextField.hasText, dateTextField.hasText, percentTextField.hasText {
            simulateButton.backgroundColor = #colorLiteral(red: 0, green: 0.7850220799, blue: 0.7006854415, alpha: 1)
            simulateButton.isEnabled = true
        }
    }
}
