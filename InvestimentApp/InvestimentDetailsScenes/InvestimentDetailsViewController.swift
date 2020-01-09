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
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var yieldMoneyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var simulateAgainButton: UIButton!
    
    private let presenter = InvestimentDetailsPresenter()
    private let reuseIdentifier = "investimentCell"
    private let numberOfLines = 12
    private var investiment:Investiment!
    typealias u = Utils
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        
        let labelsText = fillTableLabels(indexPath.row)
        cell.setupCell(contextual: labelsText.0, value: labelsText.1)
        
        return cell
    }
}


//MARK: - Data Formatter
extension InvestimentDetailsViewController {
    
    private func fillTableLabels(_ index:Int) -> (String, String) {
        
        var labelsText:(String, String) = ("", "")
        
        switch index {
        case 0:
            labelsText = ("Valor aplicado inicialmente","\(presenter.brMoney(investiment.investmentParameter?.investedAmount ?? 0.0))")
        case 1:
            labelsText = ("Valor bruto do investimento","\(presenter.brMoney(investiment.grossAmount ?? 0.0))")
        case 2:
            labelsText = ("Valor do rendimento","\(presenter.brMoney(investiment.grossAmountProfit ?? 0.0))")
        case 3:
            labelsText = ("IR sobre o investimento","\(presenter.brMoney(investiment.taxesAmount ?? 0.0))(\(presenter.percentSymbol(investiment.taxesRate ?? 0.0)))")
        case 4:
            labelsText = ("Valor líquido do investimento","\(presenter.brMoney(investiment.netAmount ?? 0.0))")
        case 6:
            labelsText = ("Data de resgate","\(presenter.strDateFromAPI(from: investiment.investmentParameter?.maturityDate ?? ""))")
        case 7:
            labelsText = ("Dias corridos","\(investiment.investmentParameter?.maturityTotalDays?.description ?? "")")
        case 8:
            labelsText = ("Rendimento mensal","\(presenter.percentSymbol(investiment.monthlyGrossRateProfit ?? 0.0))")
        case 9:
            labelsText = ("Percentual do CDI do investimento","\(presenter.percentSymbol(investiment.investmentParameter?.rate ?? 0.0))")
        case 10:
            labelsText = ("Rentabilidade anual","\(presenter.percentSymbol(investiment.annualNetRateProfit ?? 0.0))")
        case 11:
            labelsText = ("Rentabilidade no período","\(presenter.percentSymbol(investiment.annualGrossRateProfit ?? 0.0))")
        default:
            labelsText = ("","")
        }
        
        return labelsText
    }
}
