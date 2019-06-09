//
//  SignInViewController.swift
//  DayBook
//
//  Created by Илья on 6/8/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST

class SignInViewController: UIViewController{

    @IBOutlet private weak var ibHeaderView: UIView!
    @IBOutlet weak var ibSignInButton: UIButton!
    @IBOutlet weak var ibTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibHeaderView.layer.cornerRadius = 5
        ibTextLabel.text = "Dear friend!\nWe know you\'re looking forward to start!\nSo to make it easy for you we made it possible to Sign In with a single button!\nSo click it and let\'s simplify your life!"
        ibHeaderView.dropShadow()
        ibSignInButton.dropShadow()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        if (GIDSignIn.sharedInstance()?.hasAuthInKeychain())! {
            GIDSignIn.sharedInstance()?.signInSilently()
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension SignInViewController: GIDSignInUIDelegate, GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            User.instance.getCurrentUser(user: user)
            performSegue(withIdentifier: "showFeed", sender: nil)
        }
    }
}
