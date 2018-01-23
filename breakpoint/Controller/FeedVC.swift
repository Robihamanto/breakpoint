//
//  FeedVC.swift
//  breakpoint
//
//  Created by Robihamanto on 21/01/18.
//  Copyright © 2018 Robihamanto. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllMessage { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.feedTableView.reloadData()
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        DataService.instance.getUsername(forUid: message.senderId) { (returnedUsername) in
            cell.configureCell(forString: image!, forEmail: returnedUsername, andMessage: message.content)
        }
        
        
        return cell
    }
    
    
}
