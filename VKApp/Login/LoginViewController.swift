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
    
 
    let userSession = UserSessions.instance
    var getVKData = VKGetData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openLoginForm(perms: [.friends, .offline, .photos, .status, .wall])
        
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
            getVKData.goGeting()
        }
        
    }
    
    
}

