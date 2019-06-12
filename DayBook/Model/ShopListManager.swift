//
//  ShopListManager.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class ShopListManager{
    public static let instance = ShopListManager()
    private var shopList: [String] = []
    private init(){}
    
    func addProduct(product: String){
        shopList.append(product)
    }
    
    func editProduct(at index: Int, newValue: String){
        shopList[index] = newValue
    }
    
    func removeProduct(at index: Int){
        shopList.remove(at: index)
    }
    
    func getShoppingList() -> [String]{
        return shopList
    }
    
    func writeTasksIntoFile(){
        var shoppingString = ""
        for item in shopList{
            shoppingString+=item+";"
        }
        LocalFileManager.instance.writeFile(fileName: "shoppingList", text: shoppingString)
    }
    
    func readTasksFromFile(){
        let tasksList = LocalFileManager.instance.readFile(fileName: "shoppingList")
        let readItems = tasksList.split(separator: ";")
        for readItem in readItems{
            shopList.append(String(readItem))
        }
    }
}
