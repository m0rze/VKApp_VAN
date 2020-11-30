//
//  VKGetData.swift
//  VKApp
//
//  Created by Алексей Виноградов on 26.11.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit
import Alamofire

struct vkApiGetData {
    var host = "https://"
    var url = "api.vk.com"
    var path = "/method/"
    
    var baseURL: String {
        return host + url + path
    }
}

class ResFriendsResponse: Decodable {
    let response: FriendsResponse
}
class FriendsResponse: Decodable {
    let items: [FriendsData]
}


class ResFriendPhotosResponse: Decodable {
    let response: FriendPhotosResponse
}
class FriendPhotosResponse: Decodable {
    let items: [FriendPhotos]
}

class ResGroupsResponse: Decodable {
    let response: GroupsResponse
}
class GroupsResponse: Decodable {
    let items: [UserGroups]
}

class VKGetData {
    
    let vkGetBaseData = vkApiGetData()
    let userSession = UserSessions.instance
    
    static let shared = VKGetData()
    
    private init() {}
    
    @discardableResult
    func getFriendsList(completion: @escaping ([FriendsData]?) -> Void) -> Request {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "friends.get"
        let parameters: Parameters = [
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "order" : "name",
            "fields" : "nickname,status,photo_100",
            "v" : "5.68"
        ]
        
        return Session.default.request(apiVKGetURL, parameters: parameters).responseData { response in
            guard let data = response.value,
                  let friends = try? JSONDecoder().decode(ResFriendsResponse.self, from: data).response.items
            else {
                completion(nil)
                return
            }
            completion(friends)
        }
        
    }
    
    @discardableResult
    func getPhotosList(ownerId: Int, completion: @escaping ([FriendPhotos]?) -> Void) -> Request {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "photos.getAll"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "owner_id" : ownerId,
            "count" : "10",
            "v" : "5.68"
   
        ]
        return Session.default.request(apiVKGetURL, parameters: parameters).responseData { response in
            guard let data = response.value,
                  let friendPhotos = try? JSONDecoder().decode(ResFriendPhotosResponse.self, from: data).response.items
            else {
                completion(nil)
                return
            }
            //print(friendPhotos)
            completion(friendPhotos)
        }
        
    }
    
    @discardableResult
    func getGroupsList(completion: @escaping ([UserGroups]?) -> Void) -> Request {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "groups.get"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "extended" : "1",
            "fields" : "description",
            "v" : "5.68"
            
            
        ]
        return Session.default.request(apiVKGetURL, parameters: parameters).responseData { response in
            guard let data = response.value,
                  let userGroups = try? JSONDecoder().decode(ResGroupsResponse.self, from: data).response.items
            else {
                completion(nil)
                return
            }
            //print(userGroups)
            completion(userGroups)
        }
        
    }
    
    func searchGroups(q: String) {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "groups.search"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "q" : q,
            "count" : "10",
            "v" : "5.68"
            
            
        ]
        AF.request(apiVKGetURL, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n=================== SEARCH GROUPS =============================\n")
            print(response.value!)
            
        }
        
    }
}
