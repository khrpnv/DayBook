//
//  NotesViewController.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import GoogleSignIn

class NotesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var noteTitle = ""
    private var dataSource: [Note] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesManager.instance.readTasksFromFile()
        styleNavigationBar()
        styleTableView()
        setupDelegates()
        setupDataSource()
        setupObservers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? SingleNoteViewController{
            if segue.identifier == "showNote"{
                guard let cell = sender as? NoteTableViewCell else {return}
                guard let indexPath = tableView.indexPath(for: cell) else {return}
                destVC.currentNote = dataSource[indexPath.section]
                destVC.noteIndex = indexPath.section
            } else if segue.identifier == "addNote"{
                destVC.currentNote = Note(title: noteTitle, content: "")
                destVC.newNote = true
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    func styleNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764706, green: 0.4784313725, blue: 0.3843137255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    func styleTableView(){
        self.tableView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
    }
    
    func setupDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(setupDataSource), name: .DeleteNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupDataSource), name: .EditNote, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupDataSource), name: .AddNote, object: nil)
    }
    
    @IBAction func addNewNote(_ sender: Any) {
        let alertController = UIAlertController(title: "Note title", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                self.noteTitle = text
                self.performSegue(withIdentifier: "addNote", sender: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteTableViewCell else {
            fatalError("Error: cell doesn`t exist")
        }
        let currentNote = dataSource[indexPath.section]
        cell.backgroundColor = #colorLiteral(red: 0.9847301841, green: 0.9656520486, blue: 0.9443842769, alpha: 1)
        cell.setupCell(note: currentNote)
        cell.addTopBorderWithColor(color: .lightGray, width: 1)
        cell.addBottomBorderWithColor(color: .lightGray, width: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            NotesManager.instance.removeNote(at: indexPath.section)
            self?.setupDataSource()
        }
        return [delete]
    }
    
}

//MARK: - Observers
extension NotesViewController{
    @objc func setupDataSource(){
        dataSource = NotesManager.instance.getNotesList()
    }
}
