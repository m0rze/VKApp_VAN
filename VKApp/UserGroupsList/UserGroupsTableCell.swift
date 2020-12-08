//
//  UserGroupsTableCell.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class UserGroupsTableCell: UITableViewCell {

    @IBOutlet weak var userGroupsLabel: UILabel!
    @IBOutlet weak var userGroupsIcon: UIImageView!
    
    func configCell(groupData: UserGroups) {
        
        userGroupsLabel.text = groupData.name
        userGroupsIcon.load(url: URL(string: groupData.photo_200)!)
        
    }

}
