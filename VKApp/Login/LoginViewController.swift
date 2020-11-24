//
//  LoginViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit
import Alamofire
import WebKit
class LoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var loginWebView: WKWebView! {
        didSet {
            loginWebView.navigationDelegate = self
        }
    }
    
    enum vkApiGetData: String{
        case host = "https://"
        case url = "api.vk.com"
        case path = "/method/"
    }
    
    let userSession = UserSessions.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openLoginForm(perms: [.friends, .offline, .photos, .status, .wall])
        
    }
    
    func goGeting(){
        
        getFriendsList()
        getPhotosList(ownerId: "-1")
        getGroupsList()
        searchGroups(q: "geekbrains")
        
    }
    
    func openLoginForm(perms: VKScopeBitMask) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7675291"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: String(perms.rawValue)),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        loginWebView.load(request)
        
    }
    
    func getFriendsList() {
        
        let apiVKGetURL = vkApiGetData.host.rawValue + vkApiGetData.url.rawValue + vkApiGetData.path.rawValue + "friends.get"
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
        
        let apiVKGetURL = vkApiGetData.host.rawValue + vkApiGetData.url.rawValue + vkApiGetData.path.rawValue + "photos.getAll"
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
        
        let apiVKGetURL = vkApiGetData.host.rawValue + vkApiGetData.url.rawValue + vkApiGetData.path.rawValue + "groups.get"
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
        
        let apiVKGetURL = vkApiGetData.host.rawValue + vkApiGetData.url.rawValue + vkApiGetData.path.rawValue + "groups.search"
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
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        print(url)
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        let userId = params["user_id"]
        
        userSession.token = token ?? ""
        userSession.userId = userId ?? ""
        
        decisionHandler(.cancel)
        if userSession.token != "" {
            goGeting()
        }
        
    }
    
    
}

