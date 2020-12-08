//
//  JSONFriends.swift
//  VKApp
//
//  Created by Алексей Виноградов on 27.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class FriendsData: Object, Decodable {

    @objc dynamic var firstname = ""
    @objc dynamic var id = 0
    @objc dynamic var lastname = ""
    @objc dynamic var avatarphoto: String = ""
    @objc dynamic var firstLetter: String { return String(firstname.first!)}
    
    override init(){
        super.init()
    }

    enum ItemsKeys: String, CodingKey {

        case firstname = "first_name"
        case lastname = "last_name"
        case avatarphoto = "photo_100"
        case id

    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.firstname = try values.decode(String.self, forKey: .firstname)
        self.lastname = try values.decode(String.self, forKey: .lastname)
        self.avatarphoto = try values.decode(String.self, forKey: .avatarphoto)
        self.id = try values.decode(Int.self, forKey: .id)

    }

}
