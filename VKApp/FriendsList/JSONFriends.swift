//
//  JSONFriends.swift
//  VKApp
//
//  Created by Алексей Виноградов on 27.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import UIKit


class FriendsData: Decodable {

    var firstname = ""
    var id = 0
    var lastname = ""
    var avatarphoto: URL
    var firstLetter: String { return String(firstname.first!)}

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
        self.avatarphoto = try values.decode(URL.self, forKey: .avatarphoto)
        self.id = try values.decode(Int.self, forKey: .id)

    }

}
