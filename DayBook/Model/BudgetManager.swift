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
    private init(){
    }
    private var container: [BudgetData] = []
    private var startSum: Double = 0
    private var currentSum: Double = 0
    
    func getData() -> [BudgetData]{
        return container
    }
    
    func addData(data: BudgetData){
        container.append(data)
        if data.lose{
            currentSum -= data.sum
        } else {
            currentSum += data.sum
        }
    }
    
    func setStartSum(value: Double){
        startSum = value
    }
    
    private func calculateCurrent() {
        currentSum = startSum
        for data in container{
            if data.lose {
                currentSum-=data.sum
            } else {
                currentSum+=data.sum
            }
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
    }
    
    func writeTasksIntoFile(){
        var resultString = "\(startSum)\n"
        for data in container{
            resultString += String(format:"%.1f", data.sum) + "/"
            resultString += data.comment+"/"
            resultString += String(data.lose)+"|"
        }
        LocalFileManager.instance.writeFile(fileName: "budget", text: resultString)
    }
    
    func readTasksFromFile(){
        let budgetList = LocalFileManager.instance.readFile(fileName: "budget")
        if budgetList.count == 0{
            return
        }
        let startSumData = budgetList.split(separator: "\n")
        self.startSum = String(startSumData[0]).toDouble() ?? 1000
        if startSumData.count == 1{
            return
        }
        let dataArray = startSumData[1].split(separator: "|")
        for info in dataArray{
            let infoArray = info.split(separator: "/")
            let sum = String(infoArray[0]).toDouble() ?? 0
            let comment = String(infoArray[1])
            var lose = false
            if String(infoArray[2]) == "true"{
                lose = true
            }
            let finalData = BudgetData(sum: sum, comment: comment, lose: lose)
            container.append(finalData)
        }
    }
    
}
