//
//  TODOViewController.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import GoogleSignIn

class TODOViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addTask: UIBarButtonItem!
    private var dataSource: [String] = []{
        didSet{
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    private var taskToSend: String = "#TODO: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TODOManager.instance.readTasksFromFile()
        tableView.delegate = self
        tableView.dataSource = self
        setupDataSource()
        styleNavigationBar()
        setupDataSource()
        setupObservers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ChatViewController{
            if segue.identifier == "shareTask"{
                destVC.taskToSend = self.taskToSend
            }
        }
    }

    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTaskPressed(_ sender: Any) {
        self.present(UIAlertController.AddTaskAlertWindow(), animated: true, completion: nil)
    }
    
    func styleNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764706, green: 0.4784313725, blue: 0.3843137255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .default
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        self.title = weekday
    }
    
    func setupDataSource(){
        dataSource = TODOManager.instance.getTasks()
    }
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView), name: .AddTask, object: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TODOViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) 
        cell.textLabel?.text = "⚫️ " + dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Done") { [weak self] (action, indexPath) in
            TODOManager.instance.removeTask(at: indexPath.row)
            self?.updateTableView()
        }
        delete.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let share = UITableViewRowAction(style: .normal, title: "Share") { [weak self](action, indexPath) in
            self?.taskToSend += self?.dataSource[indexPath.row] ?? ""
            self?.performSegue(withIdentifier: "shareTask", sender: nil)
        }
        share.backgroundColor = #colorLiteral(red: 0.1955395341, green: 0.5143008232, blue: 1, alpha: 1)
        return [delete, share]
    }
}

//MARK: - Observers
extension TODOViewController{
    @objc func updateTableView(){
        setupDataSource()
    }
}
