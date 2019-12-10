//
//  InvestimentDetailsViewController.swift
//  InvestimentApp
//
//  Created by Israel on 10/12/19.
//  Copyright © 2019 israel3D. All rights reserved.
//

import UIKit

class InvestimentDetailsViewController: UIViewController {

    
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var yieldMoneyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var simulateAgainButton: UIButton!
    
    let reuseIdentifier = "investimentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InvestimentDetailsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func backToSimulateAgain(_ sender: UIButton) {

    }
    
}


//MARK: - UITableViewDataSource
extension InvestimentDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! InvestimentDetailsTableViewCell
        
        cell.setupCell(contextual: "Algo", value: "Detalhe")
        
        return cell
    }
    
}


//MARK: - UITableViewDelegate
extension InvestimentDetailsViewController: UITableViewDelegate {
    
}
