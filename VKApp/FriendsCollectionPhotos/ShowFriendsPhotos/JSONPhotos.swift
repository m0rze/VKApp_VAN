//
//  JSONPhotos.swift
//  VKApp
//
//  Created by Алексей Виноградов on 30.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation


class FriendPhotos: Decodable {
    
    var likesCount: Int
    var likeState: Int
    
    var album_id = 0
    var id = 0
    var photo_1280: URL
    var photo_2560: URL
    
    enum ItemsKeys: String, CodingKey {
        
        case album_id
        case photo_1280
        case photo_2560
        case id
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ItemsKeys.self)
        self.photo_1280 = try values.decode(URL.self, forKey: .photo_1280)
        self.photo_2560 = try values.decode(URL.self, forKey: .photo_2560)
        self.id = try values.decode(Int.self, forKey: .id)
        self.album_id = try values.decode(Int.self, forKey: .album_id)
        self.likesCount = 0
        self.likeState = 0
        
    }
    
}
