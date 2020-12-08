//
//  JSONPhotos.swift
//  VKApp
//
//  Created by Алексей Виноградов on 30.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import RealmSwift

class FriendPhotos: Object, Decodable {
    
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var likeState: Int = 0
    
    @objc dynamic var album_id = 0
    @objc dynamic  var id = 0
    @objc dynamic var photo_1280: String = ""
    @objc dynamic var photo_2560: String = ""
    
    override init(){
        super.init()
    }
    
    enum ItemsKeys: String, CodingKey {
        
        case album_id
        case photo_1280
        case photo_2560
        case id
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.photo_1280 = try values.decode(String.self, forKey: .photo_1280)
        self.photo_2560 = try values.decode(String.self, forKey: .photo_2560)
        self.id = try values.decode(Int.self, forKey: .id)
        self.album_id = try values.decode(Int.self, forKey: .album_id)
        self.likesCount = 0
        self.likeState = 0
        
    }
    
}
