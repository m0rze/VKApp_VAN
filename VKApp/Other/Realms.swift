//
//  Realms.swift
//  VKApp
//
//  Created by Алексей Виноградов on 03.12.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import Foundation
import RealmSwift

class RealmActions {
    
    static let shared = RealmActions()
    
    func saveRealmFriends(inRealmData : [FriendsData]) {
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(inRealmData)
        }
        
    }
    
    func loadRealmFriends() -> [FriendsData] {
        
        let realm = try! Realm()
        let friends = realm.objects(FriendsData.self)
        return Array(friends)
        
    }
    
    func saveRealmGroups(inRealmData : [FriendsData]) {
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(inRealmData)
        }
        
    }
    
}
