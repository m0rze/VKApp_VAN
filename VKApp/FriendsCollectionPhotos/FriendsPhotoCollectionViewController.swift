//
//  FriendsPhotoCollectionViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 23.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsPhotoCollectionViewController: UICollectionViewController {
    
    var friendIndex: Int?
    var photosView = ViewPhotos()
    var currentLikes: Int?
    
    var friendsPhotos: Results<FriendPhotos>!
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFriendsPhotosAndObserve()
        
    }
    
    func getFriendsPhotosAndObserve() {
        
        self.friendsPhotos = RealmActions.shared.loadRealmFriendsPhotos(friendId: friendIndex!)
        
        token = friendsPhotos?.observe(on: DispatchQueue.main, { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .update(_, let deletions, let insertions, let modifications):
                self.collectionView.performBatchUpdates({
                    
                    self.collectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) })
                    self.collectionView.deleteItems(at: deletions.map { IndexPath(row: $0, section: 0) })
                    self.collectionView.reloadItems(at: modifications.map { IndexPath(row: $0, section: 0) })
                    
                }, completion: nil)
            case .initial:
                self.collectionView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
                
            }
            
        })
        
        VKGetData.shared.getPhotosList(ownerId: friendIndex!, completion: {})
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
        photosView.friendPhotos = Array(friendsPhotos)
        photosView.currentImageIndex = indexPath.row        
        self.navigationController!.pushViewController(photosView, animated: true)
    }
    
}
