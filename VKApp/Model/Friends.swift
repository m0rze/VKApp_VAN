//
//  Friends.swift
//  VKApp
//
//  Created by Алексей Виноградов on 29.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation

struct Friends {
    let name: String
    let mainPic: String
    let pics: [FriendPhotos]?
    var firstLetter: String { return String(name.first!)}
    let about: String?
    var friendLikes: Int = 0
    var friendLikeState: Int = 0
}
