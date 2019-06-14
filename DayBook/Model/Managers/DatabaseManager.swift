//
//  DatabaseManager.swift
//  DayBook
//
//  Created by Илья on 6/14/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManager {
    public static let instance = DatabaseManager()
    private var dataBase: Connection?
    
    //MARK: - Universal columns
    private let id = Expression<Int>("id")
    private let data = Expression<String>("data")
    
    //MARK: - Tables
    private let todoList = Table("TODOlist")
    private let shoppingList = Table("ShoppingList")
    private let notesList = Table("NotesList")
    private let budgetData = Table("BudgetData")
    private let startSum = Table("StartSum")
    
    //MARK: - Specific columns
    private let noteTitle = Expression<String>("title")
    private let budgetSum = Expression<Double>("sum")
    
    //MARK: - Universal functions
    private init() {}
    func openDatabase(){
        let path = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!
        do {
            dataBase = try Connection("\(path)/Daybook.sqlite3")
        } catch {
            dataBase = nil
            print ("Unable to open database")
        }
    }
    
    func createTables() {
        do {
            try dataBase!.run(todoList.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(data)
            })
            try dataBase!.run(shoppingList.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(data)
            })
            try dataBase!.run(notesList.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(data)
                table.column(noteTitle)
            })
            try dataBase!.run(budgetData.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(data)
                table.column(budgetSum)
            })
            try dataBase!.run(startSum.create(ifNotExists: true) { table in
                table.column(budgetSum, primaryKey: true)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    private func removeData(id: Int, table: Table){
        do {
            let task = table.filter(self.id == id)
            try dataBase!.run(task.delete())
        } catch {
            print("Delete failed")
        }
    }
    
    private func addData(id: Int, data: String, table: Table){
        do {
            let insert = table.insert(self.id <- id, self.data <- data)
            try dataBase!.run(insert)
        } catch {
            print("Insert failed")
        }
    }
    
    private func updateData(id: Int, newValue: String, table: Table){
        let dataToUpdate = table.filter(self.id == id)
        do {
            let update = dataToUpdate.update(self.data <- newValue)
            try dataBase!.run(update)
        } catch {
            print("Update failed: \(error)")
        }
    }
    
    private func removeAllData(table: Table){
        do {
            try dataBase!.run(table.delete())
        } catch {
            print("Remove failed")
        }
    }
    
    //MARK: - Tasks CRUD functions
    func addTask(task: Task) {
        addData(id: task.id, data: task.taskText, table: todoList)
    }
    
    func removeTask(task: Task){
        removeData(id: task.id, table: todoList)
    }
    
    func updateTask(task: Task){
        updateData(id: task.id, newValue: task.taskText, table: todoList)
    }
    
    func getTasks() -> [Task]{
        var tasks:[Task] = []
        do {
            for taskData in try dataBase!.prepare(self.todoList) {
                tasks.append(Task(id: taskData[id], task: taskData[data]))
            }
        } catch {
            print("Selection failed")
        }
        return tasks
    }
    
    //MARK: Shoppinglist CRUD functions
    func addProduct(product: Product) {
        addData(id: product.id, data: product.productName, table: shoppingList)
    }
    
    func removeProduct(product: Product){
        removeData(id: product.id, table: shoppingList)
    }
    
    func updateProducts(product: Product){
        updateData(id: product.id, newValue: product.productName, table: shoppingList)
    }
    
    func getShoppingList() -> [Product]{
        var products: [Product] = []
        do{
            for productFromBase in try dataBase!.prepare(self.shoppingList){
                products.append(Product(id: productFromBase[id], productName: productFromBase[data]))
            }
        } catch {
            print("Selection failed")
        }
        return products
    }
    
    //MARK: - Noteslist CRUD functions
    func addNote(note: Note){
        do {
            let insert = notesList.insert(id <- note.id, noteTitle <- note.title, data <- note.content)
            try dataBase!.run(insert)
        } catch {
            print("Insertion failed")
        }
    }
    
    func updateNote(note: Note){
        updateData(id: note.id, newValue: note.content, table: notesList)
    }
    
    func removeNote(note: Note){
        removeData(id: note.id, table: notesList)
    }
    
    func getNotesList() -> [Note]{
        var notes: [Note] = []
        do{
            for noteData in try dataBase!.prepare(self.notesList){
                notes.append(Note(id: noteData[id], title: noteData[noteTitle], content: noteData[data]))
            }
        } catch {
            print("Selection failed")
        }
        return notes
    }
    
    //MARK: - Budgetdata CRUD functions
    func addBudgetInfo(budgetInfo: BudgetData){
        do {
            let insert = budgetData.insert(id <- budgetInfo.id, data <- budgetInfo.comment, budgetSum <- budgetInfo.sum)
            try dataBase!.run(insert)
        } catch {
            print("Insertion failed")
        }
    }
    
    func removeBudgetInfo(){
        removeAllData(table: budgetData)
    }
    
    func getBudgetInfo() -> [BudgetData]{
        var budget: [BudgetData] = []
        do {
            for queryData in try dataBase!.prepare(self.budgetData){
                budget.append(BudgetData(sum: queryData[budgetSum], comment: queryData[data], id: queryData[id]))
            }
        } catch {
            print("Selection failed")
        }
        print(budget)
        return budget
    }
    
    //MARK: - StartSum CRUD functions
    func addStartSum(sum: Double){
        do {
            let insert = startSum.insert(budgetSum <- sum)
            try dataBase!.run(insert)
        } catch {
            print("Insertion failed")
        }
    }
    
    func removeStartSum(){
        removeAllData(table: startSum)
    }
    
    func getStartSum() -> Double{
        var startSum: Double = 0
        do{
            for data in try dataBase!.prepare(self.startSum){
                startSum = data[budgetSum]
            }
        } catch {
            print("Selection failed")
        }
        return startSum
    }
}
