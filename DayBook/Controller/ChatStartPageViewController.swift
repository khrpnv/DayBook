//
//  ChatStartPageViewController.swift
//  DayBook
//
//  Created by Илья on 6/10/19.
//  Copyright © 2019 Илья. All rights reserved.
//

import UIKit
import GoogleSignIn

class ChatStartPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar()
    }
    
    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    func styleNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764706, green: 0.4784313725, blue: 0.3843137255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .default
    }
}
