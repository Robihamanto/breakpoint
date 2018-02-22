//
//  NewGroupVC.swift
//  breakpoint
//
//  Created by Robihamanto on 01/02/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class NewGroupVC: UIViewController {

    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var peopleTableView: UITableView!
    
    var emailUsers = [String]()
    var selectedEmailUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldWasChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }
    
    @objc func textFieldWasChange() {
        if emailSearchTextField.text == "" {
            emailUsers = []
            peopleTableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailUsers) in
                self.emailUsers = returnedEmailUsers
                self.peopleTableView.reloadData()
            })
        }
    }

    @IBAction func doneButtonDidTap(_ sender: Any) {
        
    }
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            print("error")
            return UserCell()
        }
        
        if selectedEmailUsers.contains(emailUsers[indexPath.row]) {
            cell.cofigureCell(forImageName: "defaultProfileImage", userEmail: emailUsers[indexPath.row], andIsChecked: true)
        } else {
            cell.cofigureCell(forImageName: "defaultProfileImage", userEmail: emailUsers[indexPath.row], andIsChecked: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = peopleTableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !selectedEmailUsers.contains(cell.emailLabel.text!) {
            selectedEmailUsers.append(cell.emailLabel.text!)
            groupMemberLabel.text = selectedEmailUsers.joined(separator: ", ")
            doneButton.isHidden = false
        } else {
            selectedEmailUsers = selectedEmailUsers.filter( { $0 != cell.emailLabel.text! })
            if selectedEmailUsers.count > 0 {
                groupMemberLabel.text = selectedEmailUsers.joined(separator: ", ")
            } else {
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
        }
    }
    
}

extension NewGroupVC: UITextFieldDelegate {
    
}
