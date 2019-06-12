//
//  ShoppingListViewController.swift
//  DayBook
//
//  Created by Илья on 6/12/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: [String] = []{
        didSet{
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    private var taskToSend: String = "#Buy: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupDataSource()
        setupObservers()
        styleView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ChatViewController{
            if segue.identifier == "shareProduct"{
                destVC.taskToSend = self.taskToSend
            }
        }
    }
    
    func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupDataSource(){
        dataSource = ShopListManager.instance.getShoppingList()
    }
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: .AddProduct, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: .EditProduct, object: nil)
    }
    
    func styleView(){
        self.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.present(UIAlertController.AddTaskAlertWindow(tag: .Product), animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = "🔵 " + dataSource[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Buy") { [weak self] (action, indexPath) in
            ShopListManager.instance.removeProduct(at: indexPath.row)
            self?.updateTableView()
        }
        delete.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let share = UITableViewRowAction(style: .normal, title: "Share") { [weak self] (action, indexPath) in
            self?.taskToSend += self?.dataSource[indexPath.row] ?? ""
            self?.performSegue(withIdentifier: "shareProduct", sender: nil)
        }
        share.backgroundColor = #colorLiteral(red: 0.1955395341, green: 0.5143008232, blue: 1, alpha: 1)
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] (action, indexPath) in
            self?.present(UIAlertController.EditTaskAlertWindow(index: indexPath.row, oldValue: self?.dataSource[indexPath.row] ?? "", tag: .Product), animated: true, completion: nil)
        }
        edit.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return [delete, share, edit]
    }
}

//MARK: - Observers
extension ShoppingListViewController{
    @objc func updateTableView(){
        setupDataSource()
    }
}
