//
//  BudgetManager.swift
//  DayBook
//
//  Created by Илья on 6/13/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class BudgetManager{
    public static let instance = BudgetManager()
    private var container: [BudgetData] = []
    private var startSum: Double = 0
    private var currentSum: Double = 0
    
    private init(){
        container = DatabaseManager.instance.getBudgetInfo()
        startSum = DatabaseManager.instance.getStartSum()
    }
    
    func getData() -> [BudgetData]{
        return container
    }
    
    func addData(data: BudgetData){
        if data.sum == 0 {
            return
        }
        container.append(data)
        currentSum += data.sum
        DatabaseManager.instance.addBudgetInfo(budgetInfo: data)
    }
    
    func setStartSum(value: Double){
        startSum = value
        DatabaseManager.instance.addStartSum(sum: value)
    }
    
    private func calculateCurrent() {
        currentSum = startSum
        for data in container{
            currentSum += data.sum
        }
    }
    
    func getCurrentSum() -> Double{
        calculateCurrent()
        return currentSum
    }
    
    func getStartSum() -> Double{
        return startSum
    }
    
    func setCurrentSum(){
        calculateCurrent()
    }
    
    func refreshData(){
        container = []
        DatabaseManager.instance.removeBudgetInfo()
    }
    
}
