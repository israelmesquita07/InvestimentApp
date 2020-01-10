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
            titleResultLabel.accessibilityTraits = .staticText
        }
    }
    @IBOutlet weak var totalMoneyLabel: UILabel! {
        didSet {
            totalMoneyLabel.isAccessibilityElement = true
            totalMoneyLabel.accessibilityTraits = .staticText
        }
    }
    @IBOutlet weak var yieldMoneyIntroLabel: UILabel! {
        didSet {
            yieldMoneyIntroLabel.isAccessibilityElement = true
            yieldMoneyIntroLabel.accessibilityLabel = Constants.kProfitabilityLabel
            yieldMoneyIntroLabel.accessibilityTraits = .staticText
        }
    }
    @IBOutlet weak var yieldMoneyLabel: UILabel! {
        didSet {
            yieldMoneyLabel.isAccessibilityElement = true
            yieldMoneyLabel.accessibilityTraits = .staticText
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var simulateAgainButton: UIButton! {
        didSet {
            simulateAgainButton.isAccessibilityElement = true
            simulateAgainButton.accessibilityLabel = Constants.kSimulateAgainButton
            simulateAgainButton.accessibilityTraits = .button
        }
    }
    
    private let presenter = InvestimentDetailsPresenter()
    private let reuseIdentifier = "investimentCell"
    private let numberOfLines = 12
    private var investiment:Investiment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateFonts(label: simulateAgainButton.titleLabel ?? UILabel(), style: .headline)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showInvestiments()
    }
    
    //    init(investiments:Investiment) {
    //        print("investiments: \(investiments)")
    //        super.init(nibName: nil, bundle: nil)
    ////        self.arrInvestiment = investiments
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        super.init(coder: coder)
    //    }
    
    class func createWith(injection:Investiment) -> InvestimentDetailsViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InvestimentDetailsViewController") as! InvestimentDetailsViewController
        vc.investiment = injection
        return vc
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "InvestimentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        //        tableView.register(InvestimentDetailsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func showInvestiments() {
        totalMoneyLabel.text = presenter.brMoney(investiment.grossAmount ?? 0.0)
        yieldMoneyLabel.text = presenter.brMoney(investiment.grossAmountProfit ?? 0.0)
    }
    
    private func updateFonts(label:UILabel, style:UIFont.TextStyle) {
        label.font = UIFont.preferredFont(forTextStyle: style)
    }
    
    @IBAction func backToSimulateAgain(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableViewDataSource
extension InvestimentDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLines
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! InvestimentDetailsTableViewCell
        
        let labelsText = fillTableLabels(indexPath.row, cell)
        cell.setupCell(contextual: labelsText.0, value: labelsText.1)
        
        return cell
    }
}


//MARK: - Data Formatter
extension InvestimentDetailsViewController {
    
    private func fillTableLabels(_ index:Int,_ cell:UITableViewCell) -> (String, String) {
        
        var labelsText:(String, String) = ("", "")
        
        switch index {
        case 0:
            labelsText = (Constants.kInvestedAmount,"\(presenter.brMoney(investiment.investmentParameter?.investedAmount ?? 0.0))")
        case 1:
            labelsText = (Constants.kGrossAmount ,"\(presenter.brMoney(investiment.grossAmount ?? 0.0))")
        case 2:
            labelsText = (Constants.kGrossAmountProfit,"\(presenter.brMoney(investiment.grossAmountProfit ?? 0.0))")
        case 3:
            labelsText = (Constants.kTaxesAmount,"\(presenter.brMoney(investiment.taxesAmount ?? 0.0))(\(presenter.percentSymbol(investiment.taxesRate ?? 0.0)))")
        case 4:
            labelsText = (Constants.kNetAmount,"\(presenter.brMoney(investiment.netAmount ?? 0.0))")
        case 6:
            labelsText = (Constants.kMaturityDate,"\(presenter.strDateFromAPI(from: investiment.investmentParameter?.maturityDate ?? ""))")
        case 7:
            labelsText = (Constants.kMaturityTotalDays,"\(investiment.investmentParameter?.maturityTotalDays?.description ?? "")")
        case 8:
            labelsText = (Constants.kMonthlyGrossRateProfit,"\(presenter.percentSymbol(investiment.monthlyGrossRateProfit ?? 0.0))")
        case 9:
            labelsText = (Constants.kRate,"\(presenter.percentSymbol(investiment.investmentParameter?.rate ?? 0.0))")
        case 10:
            labelsText = (Constants.kAnnualNetRateProfit,"\(presenter.percentSymbol(investiment.annualNetRateProfit ?? 0.0))")
        case 11:
            labelsText = (Constants.kAnnualGrossRateProfit,"\(presenter.percentSymbol(investiment.annualGrossRateProfit ?? 0.0))")
        default:
            labelsText = ("","")
            cell.isAccessibilityElement = false
            cell.contentView.isAccessibilityElement = false
        }
        
        return labelsText
    }
}
