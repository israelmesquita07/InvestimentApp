//
//  InvestimentDetailsViewController.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

protocol InvestimentDetailsViewControllerProtocol: AnyObject {
    func showInvestiments(investiments: Investiment)
}

class InvestimentDetailsViewController: UIViewController, InvestimentDetailsViewControllerProtocol {
    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var yieldMoneyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var simulateAgainButton: UIButton!
    
    private let reuseIdentifier = "investimentCell"
    private var arrInvestiment:[Investiment]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    init(investiments:[Investiment]) {
        super.init(nibName: nil, bundle: nil)
        self.arrInvestiment = investiments
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InvestimentDetailsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func showInvestiments(investiments: Investiment) {
        
    }
    
    private func fillTableLabels(_ investiment:Investiment,_ index:Int) -> (String, String) {
        
        var labelsText:(String, String) = ("", "")
        
        switch index {
        case 0:
            labelsText = (investiment.investmentParameter?.maturityDate ?? "","\(investiment.annualGrossRateProfit ?? 0.0)")
        default:
            labelsText = ("","")
        }
        
        return labelsText
    }
    
    @IBAction func backToSimulateAgain(_ sender: UIButton) {

    }
    
}

//MARK: - UITableViewDataSource
extension InvestimentDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvestiment.count //12linhas cinta do  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! InvestimentDetailsTableViewCell
        
        let index = indexPath.row
        let investiment = arrInvestiment[index]
        
        let labelsText = fillTableLabels(investiment, index)
        cell.setupCell(contextual: labelsText.0, value: labelsText.1)
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension InvestimentDetailsViewController: UITableViewDelegate {
    
}
