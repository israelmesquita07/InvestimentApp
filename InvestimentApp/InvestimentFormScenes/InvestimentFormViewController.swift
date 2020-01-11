//
//  InvestimentFormViewController.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

protocol InvestimentFormDisplayLogic: UIViewController {
    func getInvestiments()
    func showError()
    func toggleLoading(_ bool: Bool)
}

class InvestimentFormViewController: UIViewController {

    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var moneyLabel: UILabel! {
        didSet {
            moneyLabel.isAccessibilityElement = true
            moneyLabel.accessibilityLabel = Constants.kInvestedAmountLabel
            moneyLabel.accessibilityTraits = .zero
        }
    }
    @IBOutlet weak var moneyTextField: UITextField! {
        didSet {
            moneyTextField.delegate = self
            moneyTextField.isAccessibilityElement = true
            moneyTextField.accessibilityLabel = Constants.kInvestedAmountTextField
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.isAccessibilityElement = true
            dateLabel.accessibilityLabel = Constants.kMaturityDateLabel
            dateLabel.accessibilityTraits = .zero
        }
    }
    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.delegate = self
            dateTextField.isAccessibilityElement = true
            dateTextField.accessibilityLabel = Constants.kMaturityDateTextField
        }
    }
    @IBOutlet weak var percentLabel: UILabel! {
        didSet {
            percentLabel.isAccessibilityElement = true
            percentLabel.accessibilityLabel = Constants.kInvestmentCDIRateLabel
            percentLabel.accessibilityTraits = .zero
        }
    }
    @IBOutlet weak var percentTextField: UITextField! {
        didSet {
            percentTextField.delegate = self
            percentTextField.isAccessibilityElement = true
            percentTextField.accessibilityLabel = Constants.kInvestedAmountTextField
        }
    }
    @IBOutlet weak var simulateButton: UIButton! {
        didSet {
            simulateButton.isAccessibilityElement = true
            simulateButton.accessibilityLabel = Constants.kSimulateButton
            simulateButton.accessibilityTraits = .zero
        }
    }

    private let interactor = InvestimentFormInteractor()
    private let presenter = InvestimentFormPresenter()
    private let router = InvestimentFormViewRouter()

    lazy var datePicker: UIDatePicker = {
        let datePicker =
            UIDatePicker(frame: CGRect(origin: .zero,
                                       size: CGSize(width: view.frame.width,
                                       height: view.frame.height/3.3)))
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        setup()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoading.isHidden = true
    }

    private func setup() {
        presenter.investimentFormViewControllerDelegate = self
        router.viewControllerDelegate = self
        interactor.investimentFormPresenterDelegate = presenter
        interactor.investimentFormRouterDelegate = router
    }

    private func setupLayout() {
        simulateButton.isEnabled = false
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbarDatePicker
    }

    private func getParams() -> [String: Any] {
        guard let money = Double(moneyTextField.text!),
            let date = dateTextField.text,
            let percent = Int(percentTextField.text!) else {
            showError()
            return [String: Any]()
        }
        let request = Request(investedAmount: money, rate: percent, maturityDate: date)
        return request.params
    }

    @objc func dateChanged(datePicker: UIDatePicker) {
        dateFormatter(datePicker: datePicker)
    }

    @objc func doneDateSelected() {
        dateFormatter(datePicker: datePicker)
        view.endEditing(true)
    }

    private func dateFormatter(datePicker: UIDatePicker) {
        let formattedDate = Utils.dateToString(from: datePicker.date)
        dateTextField.text = formattedDate
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func simulateInvestiment(_ sender: UIButton) {
        toggleLoading(true)
        getInvestiments()
    }
}

// MARK: - InvestimentFormViewControllerProtocol
extension InvestimentFormViewController: InvestimentFormDisplayLogic {

    func getInvestiments() {
        interactor.getInvestiments(params: getParams())
    }

    func showError() {
        Utils.showAlert(delegate: self, title: "Ops!", message: "Ocorreu um erro!")
    }

    func toggleLoading(_ bool: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if bool {
                self.viewLoading.isHidden = false
                self.activityIndicator.startAnimating()
                return
            }
            self.viewLoading.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UITextFieldDelegate
extension InvestimentFormViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        if moneyTextField.hasText, dateTextField.hasText, percentTextField.hasText {
            simulateButton.backgroundColor = #colorLiteral(red: 0, green: 0.7850220799, blue: 0.7006854415, alpha: 1)
            simulateButton.isEnabled = true
        }
    }
}
