//
//  NotesManager.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class NotesManager{
    public static let instance = NotesManager()
    private init(){
        notes = DatabaseManager.instance.getNotesList()
    }
    private var notes: [Note] = []
    
    private func generateNoteTitle(content: String) -> String{
        var notesContent: [String] = []
        content.enumerateSubstrings(in: content.startIndex..<content.endIndex, options: .byWords) { (substring, _, _, _) -> () in notesContent.append(substring!)
        }
        return notesContent[0]
    }
    
    public func addNote(title: String, content: String){
        let note = Note(id: Int(arc4random()), title: title, content: content)
        notes.append(note)
        DatabaseManager.instance.addNote(note: note)
    }
    
    public func saveNoteFromMessage(content: String){
        let note = Note(id: Int(arc4random()), title: generateNoteTitle(content: content), content: content)
        notes.append(note)
        DatabaseManager.instance.addNote(note: note)
    }
    
    public func editNote(at index:Int, content:String){
        notes[index].content = content
        DatabaseManager.instance.updateNote(note: notes[index])
    }
    
    public func removeNote(at index: Int){
        let noteToRemove = notes[index]
        notes.remove(at: index)
        DatabaseManager.instance.removeNote(note: noteToRemove)
    }
    
    public func getNotesList() -> [Note]{
        return notes
    }
    
    public func getNotePreview(content: String) -> String{
        if content.count > 20{
            let index = content.index(content.startIndex, offsetBy: 20)
            let preview = content.prefix(through: index)
            return String(preview) + "..."
        } else {
            return content
        }
    }
    
}
