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
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        try? realm.write {
            realm.add(inRealmData, update: .modified)
            
        }
        
    }
    
    func loadRealmFriends() -> Results<FriendsData> {
        
        let realm = try! Realm()
        let friends = realm.objects(FriendsData.self).sorted(byKeyPath: "firstname", ascending: true)
       // print(realm.configuration.fileURL)
        return friends
        
    }
   
    
    func saveRealmFriendsPhotos(inRealmData : [FriendPhotos], friendId: Int) {
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        try? realm.write {
            let friendPhotos = realm.objects(FriendPhotos.self).filter("friendId == %@", friendId)
            realm.delete(friendPhotos)
            realm.add(inRealmData, update: .modified)
            //print(realm.configuration.fileURL)
        }
        
    }
    
    func loadRealmFriendsPhotos(friendId: Int) -> Results<FriendPhotos> {
        
        let realm = try! Realm()
        let friends = realm.objects(FriendPhotos.self).filter("friendId == %@", friendId)
        //print(realm.configuration.fileURL)
        return friends
        
    }
    
    func saveRealmUserGroups(inRealmData : [UserGroups]) {
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        try? realm.write {
            realm.add(inRealmData, update: .modified)
            //print(realm.configuration.fileURL)
        }
        
    }
    
    func loadRealmUserGroups() -> Results<UserGroups> {
        
        let realm = try! Realm()
        let userGroups = realm.objects(UserGroups.self).sorted(byKeyPath: "name", ascending: true)
        return userGroups
        
    }
    
}
