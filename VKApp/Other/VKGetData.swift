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

class VKGetData {
    
    let vkGetBaseData = vkApiGetData()
    let userSession = UserSessions.instance
    
    func goGeting(){
        
        getFriendsList()
        getPhotosList(ownerId: "-1")
        getGroupsList()
        searchGroups(q: "geekbrains")
        
    }
    
    func getFriendsList() {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "friends.get"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "order" : "name",
            "fields" : "nickname,status",
            "v" : "5.68"
            
            
        ]
        AF.request(apiVKGetURL, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n=================== FRIENDS LIST =============================\n")
            print(response.value!)
            
        }
        
    }
    
    func getPhotosList(ownerId: String) {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "photos.getAll"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "owner_id" : ownerId,
            "count" : "5",
            "v" : "5.68"
            
            
        ]
        AF.request(apiVKGetURL, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n=================== PHOTOS LIST =============================\n")
            print(response.value!)
            
        }
        
    }
    
    func getGroupsList() {
        
        let apiVKGetURL = vkGetBaseData.baseURL + "groups.get"
        let parameters: Parameters = [
            
            "access_token" : userSession.token,
            "user_id" : userSession.userId,
            "extended" : "1",
            "fields" : "description",
            "v" : "5.68"
            
            
        ]
        AF.request(apiVKGetURL, method: .get, parameters: parameters).responseJSON { response in
            print("\n\n=================== GROUPS LIST =============================\n")
            print(response.value!)
            
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
