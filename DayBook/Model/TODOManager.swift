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
        initializeTasks()
    }
    private var tasks: [String: [String]] = [:]
    
    private func initializeTasks(){
        let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        for weekday in weekdays{
            tasks[weekday] = []
        }
    }
    
    func addTask(text taskText:String){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        tasks[weekday]?.append(taskText)
    }
    
    func printTasks(){
        print(tasks)
    }
}
