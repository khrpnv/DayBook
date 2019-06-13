//
//  BudgetViewController.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet private weak var startSumLabel: UILabel!
    @IBOutlet private weak var currentSumLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: [BudgetData] = []{
        didSet{
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BudgetManager.instance.readTasksFromFile()
        setUpInfo()
        styleNavigationBar()
        setupDelegates()
        setupDataSource()
        setupObservers()
    }
    
    func styleNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764706, green: 0.4784313725, blue: 0.3843137255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupDataSource(){
        dataSource = BudgetManager.instance.getData()
    }
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setUpInfo), name: .RefreshSum, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpInfo), name: .AddBudgetInfo, object: nil)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        self.present(UIAlertController.ReloadData(), animated: true, completion: nil)
        setupDataSource()
    }
    
    @IBAction func addDataPressed(_ sender: Any) {
        self.present(UIAlertController.AddBudgetData(), animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension BudgetViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "BudgetData", for: indexPath) as? BudgetTableViewCell else {
            fatalError("Error: no such cell")
        }
        var indicator = ""
        let data = dataSource[indexPath.row]
        if data.lose{
            indicator = "-"
        } else {
            indicator = "+"
        }
        cell.initCell(indicator: indicator, sum: data.sum, comment: data.comment)
        return cell
    }
}

//MARK: - Observers
extension BudgetViewController{
    @objc func setUpInfo(){
        startSumLabel.text = "\(BudgetManager.instance.getStartSum())"
        currentSumLabel.text = "\(BudgetManager.instance.getCurrentSum())"
        setupDataSource()
    }
}
