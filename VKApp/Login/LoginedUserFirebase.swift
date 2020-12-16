//
//  LoginedUserFirebase.swift
//  VKApp
//
//  Created by Алексей Виноградов on 16.12.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import FirebaseDatabase

class LoginedUserFirebase {
    let userId: String
    let ref: DatabaseReference?
    
    init(userId: String) {
        self.ref = nil
        self.userId = userId
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.userId = userId
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "userId": userId
        ]
    }

}
