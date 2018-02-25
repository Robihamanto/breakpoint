//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Robihamanto on 23/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var sendUIView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var group: Group?
    var messages = [Message]()
    var groupMemberEmails = [String]()
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendUIView.bindToKeyboard()
        self.messagesTableView.dataSource = self
        self.messagesTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.groupTitleLabel.text = group?.title
        setMemberEmailLabel()
        self.messagesTableView.estimatedRowHeight = 0
        self.messagesTableView.estimatedSectionHeaderHeight = 0
        self.messagesTableView.estimatedSectionFooterHeight = 0
        DataService.instance.REF_GROUPS.observe(.value) { (_) in
            self.getAllMessage()
        }
    }
    
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendButtonDidTap(_ sender: Any ) {
        if messageTextField.text != "" {
            sendButton.isEnabled = false
            messageTextField.isEnabled = false
            DataService.instance.uploadPost(forUid: (Auth.auth().currentUser?.uid)!, withMessage: messageTextField.text!, andGroupKey: group?.key) { (success) in
                if success {
                    self.sendButton.isEnabled = true
                    self.messageTextField.isEnabled = true
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
    func setMemberEmailLabel(){
        DataService.instance.getEmail(forGroup: self.group!) { (returnedEmails) in
            self.groupMemberEmails = returnedEmails
            self.groupMemberLabel.text = self.groupMemberEmails.joined(separator: ", ")
        }
    }
    
    func getAllMessage(){
        DataService.instance.getAllMessage(forGroup: self.group!) { (returnedGroupMessages) in
            self.messages = returnedGroupMessages
            self.messagesTableView.reloadData()
            
            if self.messages.count > 0 {
                self.messagesTableView.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .none, animated: true)
            }
    }
}
    
}

extension GroupFeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedGroupCell") as? FeedGroupCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUsername(forUid: messages[indexPath.row].senderId) { (returnedUsername) in
            cell.configureCell(forString: image!, forEmail: returnedUsername, andMessage: self.messages[indexPath.row].content)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
