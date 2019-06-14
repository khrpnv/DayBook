//
//  TODOManager.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class TODOManager{
    public static let instance = TODOManager()
    private init(){
        tasks = DatabaseManager.instance.getTasks()
    }
    private var tasks: [Task] = []

    func addTask(text taskText:String){
        let id = Int(arc4random())
        let task = Task(id: id, task: taskText)
        tasks.append(task)
        DatabaseManager.instance.addTask(task: task)
    }
    
    func removeTask(at index: Int){
        let taskToRemove = tasks[index]
        tasks.remove(at: index)
        DatabaseManager.instance.removeTask(task: taskToRemove)
    }
    
    func editTask(at index: Int, for newValue: String){
        tasks[index].taskText = newValue
        DatabaseManager.instance.updateTask(task: tasks[index])
    }
    
    func getTasks() -> [Task]{
        return tasks
    }
}
