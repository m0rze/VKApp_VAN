//
//  sessions.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class Sessions {
    static let instance = Sessions()
       
       private init() { }
       var token: String = ""
       var userId: Int = 0
}
