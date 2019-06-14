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
    private var shopList: [Product] = []
    private init(){
        shopList = DatabaseManager.instance.getShoppingList()
    }
    
    func addProduct(product: String){
        let id = Int(arc4random())
        let product = Product(id: id, productName: product)
        shopList.append(product)
        DatabaseManager.instance.addProduct(product: product)
    }
    
    func editProduct(at index: Int, newValue: String){
        shopList[index].productName = newValue
        DatabaseManager.instance.updateProducts(product: shopList[index])
    }
    
    func removeProduct(at index: Int){
        let productToRemove = shopList[index]
        shopList.remove(at: index)
        DatabaseManager.instance.removeProduct(product: productToRemove)
    }
    
    func getShoppingList() -> [Product]{
        return shopList
    }
}
