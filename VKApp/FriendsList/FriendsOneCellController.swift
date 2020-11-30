//
//  FriendsOneCellControllerTableViewCell.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class FriendsOneCellController: UITableViewCell {
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var friendLabel: UILabel!
    
    
    func configCell(oneFriend: FriendsData) {
        self.backgroundColor = .clear
        friendLabel.text = oneFriend.firstname + " " + oneFriend.lastname
        avatarView.shadowSubView()
        avatarView.avatarImage(imgname: oneFriend.avatarphoto)

    }

}
