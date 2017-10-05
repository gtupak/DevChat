//
//  UsersVC.swift
//  DevChat
//
//  Created by Gabriel T on 2017-10-05.
//  Copyright © 2017 Gabriel T. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UsersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (uid, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject>,
                        let profile = dict["profile"],
                        let firstName = profile["firstName"] as? String {
                        let uid = uid
                        let user = User(uid: uid, firstName: firstName)
                        self.users.append(user)
                    }
                }
            }
            
            self.tableView.reloadData()
            print("users: \(self.users)")
        }) { (error) in
            print("Error while getting users: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setSelected(selected: true, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        setSelected(selected: false, indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    private func setSelected(selected: Bool, indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: selected)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = selected ? user : nil
    }

}
