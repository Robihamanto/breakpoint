//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Robihamanto on 22/01/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet weak var saySomethingTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saySomethingTextView.delegate = self
        sendButton.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonDidTap(_ sender: Any) {
        if saySomethingTextView.text != nil && saySomethingTextView.text != "Say something here.." {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(forUid: (Auth.auth().currentUser?.uid)!, withMessage: saySomethingTextView.text, andGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = true
                    print("Something wrong was happen..")
                }
            })
        }
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
