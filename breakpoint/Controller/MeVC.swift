//
//  MeVC.swift
//  breakpoint
//
//  Created by Robihamanto on 21/01/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }

    @IBAction func signOutButtonDidTap(_ sender: Any) {
        let logoutAlertPopUp = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive)
        { (buttonDidTap) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                self.present(authVC, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logoutAlertPopUp.addAction(logoutAction)
        logoutAlertPopUp.addAction(cancelAction)
        present(logoutAlertPopUp, animated: true, completion: nil)
    }
    
    
    
}
