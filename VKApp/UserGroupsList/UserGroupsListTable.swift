//
//  UserGroupsListTable.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseFirestore

class UserGroupsListTable: UITableViewController {
    
    var userGettedGroups: Results<UserGroups>!
    var stringGettedGroups: String = ""
    private var token: NotificationToken?
    let userSession = UserSessions.instance
    static let shared = UserGroupsListTable()
    var db: Firestore?
    var groupsToSend: String = ""
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        //        if segue.identifier == "addGroup" {
        //            let allGroupsController = segue.source as! SearchGroupsTable
        //            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
        //                let newUserGroup = allGroupsController.newGroups[indexPath.row]
        //                if !userGroups.contains(where: {$0.name == newUserGroup.name}) {
        //                    userGroups.append(newUserGroup)
        //                    tableView.reloadData()
        //                }
        //            }
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserGroupsAndObserve()
        
    }
    
    func getUserGroupsAndObserve() {
        
        self.userGettedGroups = RealmActions.shared.loadRealmUserGroups()

        token = userGettedGroups?.observe(on: DispatchQueue.main, { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
            case .initial:
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)

            }
        })
        VKGetData.shared.getGroupsList(completion: {})
    }


    
    func saveToFirestore(_ userGroups: [UserGroups]) {
        let jsonEncoder = JSONEncoder()
           do {
               let jsonData = try jsonEncoder.encode(userGroups)
               let jsonString = String(data: jsonData, encoding: .utf8)
            self.groupsToSend = jsonString!
           }
           catch {
               print("error")
           }
        
        let database = Firestore.firestore()
        
        database.collection("UserData").document(userSession.userId).setData(["UserGroups" : groupsToSend], merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else { print("data saved")}
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGettedGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupsCell", for: indexPath) as! UserGroupsTableCell
        
        let currentGroup = userGettedGroups[indexPath.row]
        cell.configCell(groupData: currentGroup)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let realm = try! Realm()
            let groupToDelete = realm.objects(UserGroups.self).filter("id == %@", userGettedGroups[indexPath.row].id)
            try? realm.write {
                realm.delete(groupToDelete)
            }
        default:
            break
        }
    }
}
