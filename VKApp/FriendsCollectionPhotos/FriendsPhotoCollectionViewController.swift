//
//  FriendsPhotoCollectionViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class FriendsPhotoCollectionViewController: UICollectionViewController {
    
    var friendIndex: Int?
    var photosView = ViewPhotos()
    var currentLikes: Int?
    
    var friendsPhotos: [FriendPhotos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VKGetData.shared.getPhotosList(ownerId: friendIndex!)
        VKGetData.shared.getPhotosList(ownerId: friendIndex!, completion: { [weak self] allPhotos in
            DispatchQueue.main.async { [self] in
                guard let self = self, let photos = allPhotos else { return }
                self.friendsPhotos = photos
               // print(self.friendsPhotos)
                self.photosView.friendPhotos = self.friendsPhotos
                self.collectionView.reloadData()
            }
            })
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendsPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhoto", for: indexPath) as! OneFriendCollectionViewCell
        cell.photos = friendsPhotos[indexPath.row]
        cell.configView()
        cell.likesCountUp = {
            self.friendsPhotos[indexPath.row].likesCount += 1
        }
        cell.likesCountDown = {
            self.friendsPhotos[indexPath.row].likesCount -= 1
        }

        cell.likesStateUp = {
            self.friendsPhotos[indexPath.row].likeState += 1
        }
        cell.likesStateDown = {
            self.friendsPhotos[indexPath.row].likeState -= 1
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photosView.friendPhotos = friendsPhotos
        photosView.currentImageIndex = indexPath.row        
        self.navigationController!.pushViewController(photosView, animated: true)
    }
    
}
