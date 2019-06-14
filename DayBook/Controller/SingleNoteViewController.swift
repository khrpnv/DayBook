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
    private var contentInset: CGFloat = 0
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
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
        } else {
            NotesManager.instance.editNote(at: noteIndex, content: textView.text)
            NotificationCenter.default.post(name: .EditNote, object: nil)
        }
    }
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        NotesManager.instance.removeNote(at: noteIndex)
        NotificationCenter.default.post(name: .DeleteNote, object: nil)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITextViewDelegate
extension SingleNoteViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.tintColor = .black
        doneButton.isEnabled = true
    }
}

//MARK: - Keyboard
extension SingleNoteViewController{
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            contentInset = self.textView.contentInset.bottom
            self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentInset, right: 0)
    }
}
