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
    private var notes: [String: String] = [:]
    
    public func addNote(title: String, content: String){
        notes[title] = content
    }
    
    public func printTasks(){
        print(notes)
    }
    
    public func generateNoteTitle() -> String{
        return "Note#\(notes.count+1)"
    }
}
