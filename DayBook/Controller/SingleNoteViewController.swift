//
//  SingleNoteViewController.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController {

    var currentNote: Note?
    var noteIndex: Int = -1
    var newNote: Bool = false
    private var taskToSend: String = "#Note: "
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var doneButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendNote"{
            if let destVC = segue.destination as? ChatViewController{
                destVC.taskToSend = taskToSend + textView.text
            }
        }
    }
    
    func setupUI(){
        self.navigationItem.title = currentNote?.title
        buttonsStackView.addBackground(color: #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 0.8980392157, alpha: 1))
        textView.text = currentNote?.content
        doneButton.tintColor = UIColor.clear
        doneButton.isEnabled = false
    }
    
    func setupDelegates(){
        textView.delegate = self
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.textView.endEditing(true)
        doneButton.tintColor = UIColor.clear
        doneButton.isEnabled = false
        if newNote{
            NotesManager.instance.addNote(title: navigationItem.title ?? "", content: textView.text)
            NotificationCenter.default.post(name: .AddNote, object: nil)
        }
    }
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        NotesManager.instance.removeNote(at: noteIndex)
        NotificationCenter.default.post(name: .DeleteNote, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTask(_ sender: Any) {
        NotesManager.instance.editNote(at: noteIndex, title: navigationItem.title ?? "", content: textView.text)
        NotificationCenter.default.post(name: .EditNote, object: nil)
        self.present(UIAlertController.NoteSaved(), animated: true, completion: nil)
    }
}

//MARK: - UITextViewDelegate
extension SingleNoteViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.tintColor = .black
        doneButton.isEnabled = true
    }
}
