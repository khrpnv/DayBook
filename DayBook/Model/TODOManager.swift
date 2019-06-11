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
    }
    private var tasks: [String] = []

    func addTask(text taskText:String){
        tasks.append(taskText)
    }
    
    func removeTask(at index: Int){
        tasks.remove(at: index)
    }
    
    func printTasks(){
        print(tasks)
    }
    
    func getTasks() -> [String]{
        return tasks
    }
    
    func writeTasksIntoFile(){
        var tasksString = ""
        for task in tasks{
            tasksString+=task+";"
        }
        LocalFileManager.instance.writeFile(fileName: "tasks", text: tasksString)
    }
    
    func readTasksFromFile(){
        let tasksList = LocalFileManager.instance.readFile(fileName: "tasks")
        let readTasks = tasksList.split(separator: ";")
        for readTask in readTasks{
            tasks.append(String(readTask))
        }
    }
}
