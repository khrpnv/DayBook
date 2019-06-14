//
//  User.swift
//  DayBook
//
//  Created by Илья on 6/9/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import Foundation
import GoogleSignIn

class User{
    public static let instance = User()
    private var currentUser: GIDGoogleUser?
    private init(){
        currentUser = nil
    }
    
    public func getCurrentUser(user: GIDGoogleUser){
        currentUser = user
    }
    
    public func getUserName() -> String{
        let name = currentUser?.profile.name ?? "Current user"
        return name
    }
}
