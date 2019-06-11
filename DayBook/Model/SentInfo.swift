//
//  SentInfo.swift
//  DayBook
//
//  Created by Илья on 6/11/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation

class SentInfo{
    public static let instance = SentInfo()
    private init(){}
    private var currentInfo: String = ""
    private var senderName: String = ""
    
    public func setInfo(currentInfo: String, senderName: String){
        self.currentInfo = currentInfo
        self.senderName = senderName
    }
    
    public func getInfo() -> String{
        return currentInfo
    }
    
    public func getSenderName() -> String{
        return senderName
    }
}
