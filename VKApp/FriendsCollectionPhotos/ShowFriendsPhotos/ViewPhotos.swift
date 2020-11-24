//
//  ViewPhotos.swift
//  VKApp
//
//  Created by Алексей Виноградов on 09.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class ViewPhotos: UIViewController {

    let mainView = MainView()
    var friendPhotos: [FriendImages]? = []
    var currentImageIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.currentImageIndex = currentImageIndex
        mainView.friendPhotos = friendPhotos ?? []
        mainView.setup()
    }
    
}
