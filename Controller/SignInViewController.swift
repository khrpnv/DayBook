//
//  SignInViewController.swift
//  DayBook
//
//  Created by Илья on 6/8/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
    }
}

extension SignInViewController: GIDSignInUIDelegate, GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
