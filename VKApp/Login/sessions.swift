//
//  sessions.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class UserSessions {
    static let instance = UserSessions()
    
    private init() { }
    var token: String = ""
    var userId: String = ""
}

struct VKScopeBitMask: OptionSet {
    let rawValue: Int
    
    static let friends = VKScopeBitMask(rawValue: 1 << 1)
    static let photos = VKScopeBitMask(rawValue: 1 << 2)
    static let status = VKScopeBitMask(rawValue: 1 << 10)
    static let wall = VKScopeBitMask(rawValue: 1 << 13)
    static let offline = VKScopeBitMask(rawValue: 1 << 16)
    
}
