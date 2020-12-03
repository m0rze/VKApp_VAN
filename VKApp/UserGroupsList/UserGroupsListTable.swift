//
//  UserGroupsListTable.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class UserGroupsListTable: UITableViewController {
    
    var userGroups = [UserGroups]()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            let allGroupsController = segue.source as! SearchGroupsTable
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let newUserGroup = allGroupsController.newGroups[indexPath.row]
                if !userGroups.contains(where: {$0.name == newUserGroup.name}) {                   
                    userGroups.append(newUserGroup)
                    tableView.reloadData()
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKGetData.shared.getGroupsList(completion: { [weak self] allGroups in
            DispatchQueue.main.async {
                guard let self = self, let groups = allGroups else { return }
                self.userGroups = groups
                self.tableView.reloadData()
            }
            })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupsCell", for: indexPath) as! UserGroupsTableCell
        
        let currentGroup = userGroups[indexPath.row]
        cell.configCell(groupData: currentGroup)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }    
}
