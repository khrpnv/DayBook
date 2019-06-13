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
    private init(){}
    private var notes: [Note] = []
    
    private func generateNoteTitle() -> String{
        return "Note#\(notes.count+1)"
    }
    
    public func addNote(title: String, content: String){
        notes.append(Note(title: title, content: content))
    }
    
    public func saveNoteFromMessage(content: String){
        notes.append(Note(title: generateNoteTitle(), content: content))
    }
    
    public func editNote(at index:Int, title: String, content:String){
        notes[index] = Note(title: title, content: content)
    }
    
    public func removeNote(at index: Int){
        notes.remove(at: index)
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
    
    func writeNotesIntoFile(){
        var result = ""
        for note in notes{
            result += note.title + ": " + note.content + "|"
        }
        LocalFileManager.instance.writeFile(fileName: "notes", text: result)
    }
    
    func readTasksFromFile(){
        let notesList = LocalFileManager.instance.readFile(fileName: "notes")
        let notesSplit = notesList.split(separator: "|")
        for note in notesSplit{
            let title = note.split(separator: ":")[0]
            let titleLength = title.count + 2
            let index = note.index(note.startIndex, offsetBy: titleLength)
            let content = String(note.suffix(from: index))
            let newNote = Note(title: String(title), content: content)
            notes.append(newNote)
        }
    }
    
}
