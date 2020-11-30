//
//  NewsCollection.swift
//  VKApp
//
//  Created by Алексей Виноградов on 03.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewsCell"

class NewsCollection: UICollectionViewController {
    
    var myFriends = [
        Friends(name: "Никола Тесла", mainPic: "tesla1", pics: [], about: ""),
        Friends(name: "Генри Форд", mainPic: "ford1", pics: [], about: ""),
        Friends(name: "Стив Джобс", mainPic: "jobs1", pics: [], about: ""),
        Friends(name: "Брэд Питт", mainPic: "pitt1", pics: [], about: ""),
        Friends(name: "Жюль Верн", mainPic: "verne1", pics: [], about: "")
    ]
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "NewsCell", bundle: .none), forCellWithReuseIdentifier: "NewsCell")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFriends.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        cell.configCell(currentFriend: myFriends[indexPath.row])
        cell.likesCountUp = {
            self.myFriends[indexPath.row].friendLikes += 1
        }
        cell.likesCountDown = {
            self.myFriends[indexPath.row].friendLikes -= 1
        }
        
        cell.likesStateUp = {
            self.myFriends[indexPath.row].friendLikeState += 1
        }
        cell.likesStateDown = {
            self.myFriends[indexPath.row].friendLikeState -= 1
        }
   
        return cell
    }
    
}
