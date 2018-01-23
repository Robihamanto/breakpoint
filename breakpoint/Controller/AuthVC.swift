//
//  AuthVC.swift
//  breakpoint
//
//  Created by Robihamanto on 21/01/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithEmailButtonDidTap(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }

    @IBAction func signIntWithGoogleButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func signInWithFacebookButtonDidTap(_ sender: Any) {
    }
    
    
    
}
