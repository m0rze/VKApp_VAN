//
//  JSONGroups.swift
//  VKApp
//
//  Created by Алексей Виноградов on 30.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import UIKit

class UserGroups: Decodable {
    
    var description = ""
    var id = 0
    var name = ""
    var photo_100: URL
    var photo_200: URL
    
    enum ItemsKeys: String, CodingKey {
        
        case name
        case description
        case photo_100
        case photo_200
        case id
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.description = try values.decode(String.self, forKey: .description)
        self.photo_100 = try values.decode(URL.self, forKey: .photo_100)
        self.photo_200 = try values.decode(URL.self, forKey: .photo_200)
        self.id = try values.decode(Int.self, forKey: .id)
  
    }
    
}
