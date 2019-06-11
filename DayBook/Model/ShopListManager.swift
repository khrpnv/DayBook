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
    private init(){}
    private var shopList: [String] = []
    
    public func addProduct(product: String){
        shopList.append(product)
    }
}
