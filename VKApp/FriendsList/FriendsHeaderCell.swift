//
//  FriendsHeaderCell.swift
//  VKApp
//
//  Created by Алексей Виноградов on 02.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class FriendsHeaderCell: UITableViewHeaderFooterView {
    

    @IBOutlet weak var headerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
    }
    
}
