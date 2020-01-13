//
//  InvestimentDetailsViewController.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

protocol InvestimentDetailsViewControllerProtocol: AnyObject {
    func showInvestiments()
}

class InvestimentDetailsViewController: UIViewController, InvestimentDetailsViewControllerProtocol {

    @IBOutlet weak var titleResultLabel: UILabel! {
        didSet {
            titleResultLabel.isAccessibilityElement = true
            titleResultLabel.accessibilityLabel = Constants.kInvestmentResultLabel
        }
    }
    @IBOutlet weak var totalMoneyLabel: UILabel! {
        didSet {
            totalMoneyLabel.isAccessibilityElement = true
        }
    }
    @IBOutlet weak var yieldMoneyIntroLabel: UILabel! {
        didSet {
            yieldMoneyIntroLabel.isAccessibilityElement = true
            yieldMoneyIntroLabel.accessibilityLabel = Constants.kProfitabilityLabel
        }
    }
    @IBOutlet weak var yieldMoneyLabel: UILabel! {
        didSet {
            yieldMoneyLabel.isAccessibilityElement = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var simulateAgainButton: UIButton! {
        didSet {
            simulateAgainButton.isAccessibilityElement = true
            simulateAgainButton.accessibilityLabel = Constants.kSimulateAgainButton
        }
    }

    private let presenter = InvestimentDetailsPresenter()
    private let reuseIdentifier = "investimentCell"
    private let numberOfLines = 12
    private var investiment: Investiment!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateFonts(label: simulateAgainButton.titleLabel ?? UILabel(), style: .headline)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showInvestiments()
    }

    class func instantiate(withInjection injection: Investiment) -> InvestimentDetailsViewController? {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vcInvestiment =
            storyboard.instantiateViewController(withIdentifier: "InvestimentDetailsViewController")
            as? InvestimentDetailsViewController else { return nil }
        vcInvestiment.investiment = injection
        return vcInvestiment
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "InvestimentDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }

    func showInvestiments() {
        totalMoneyLabel.text = presenter.brMoney(investiment.grossAmount ?? 0.0)
        yieldMoneyLabel.text = presenter.brMoney(investiment.grossAmountProfit ?? 0.0)
    }

    private func updateFonts(label: UILabel, style: UIFont.TextStyle) {
        label.font = UIFont.preferredFont(forTextStyle: style)
    }

    @IBAction func backToSimulateAgain(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDataSource
extension InvestimentDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLines
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
            as? InvestimentDetailsTableViewCell {

            let labelsText = fillTableLabels(indexPath.row, cell)
            cell.setupCell(contextual: labelsText.0, value: labelsText.1)

            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Data Formatter
extension InvestimentDetailsViewController {

    private func fillTableLabels(_ index: Int, _ cell: UITableViewCell) -> (String, String) {

        var labelsText: (String, String) = ("", "")
        guard let param = investiment.investmentParameter else { return ("", "") }

        switch index {
        case 0:
            labelsText = (Constants.kInvestedAmount, "\(presenter.brMoney(param.investedAmount ?? 0.0))")
        case 1:
            labelsText = (Constants.kGrossAmount, "\(presenter.brMoney(investiment.grossAmount ?? 0.0))")
        case 2:
            labelsText = (Constants.kGrossAmountProfit, "\(presenter.brMoney(investiment.grossAmountProfit ?? 0.0))")
        case 3:
            labelsText = (Constants.kTaxesAmount, "\(presenter.brMoney(investiment.taxesAmount ?? 0.0))"
                + "(\(presenter.percentSymbol(investiment.taxesRate ?? 0.0)))")
        case 4:
            labelsText = (Constants.kNetAmount, "\(presenter.brMoney(investiment.netAmount ?? 0.0))")
        case 6:
            labelsText = (Constants.kMaturityDate, "\(presenter.strDateFromAPI(from: param.maturityDate ?? ""))")
        case 7:
            labelsText = (Constants.kMaturityTotalDays, "\(param.maturityTotalDays?.description ?? "")")
        case 8:
            labelsText = (Constants.kMonthlyGrossRateProfit,
                          "\(presenter.percentSymbol(investiment.monthlyGrossRateProfit ?? 0.0))")
        case 9:
            labelsText = (Constants.kRate, "\(presenter.percentSymbol(param.rate ?? 0.0))")
        case 10:
            labelsText = (Constants.kAnnualNetRateProfit,
                          "\(presenter.percentSymbol(investiment.annualNetRateProfit ?? 0.0))")
        case 11:
            labelsText = (Constants.kAnnualGrossRateProfit,
                          "\(presenter.percentSymbol(investiment.annualGrossRateProfit ?? 0.0))")
        default:
            labelsText = ("", "")
            cell.isAccessibilityElement = false
            cell.contentView.isAccessibilityElement = false
        }

        return labelsText
    }
}
