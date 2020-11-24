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
        Friends(name: "Никола Тесла", mainPic: "tesla1", pics: [FriendImages(name: "tesla1"), FriendImages(name: "tesla2"), FriendImages(name: "tesla3")], about: "Широко известен благодаря своему вкладу в создание устройств, работающих на переменном токе, многофазных систем, синхронного генератора и асинхронного электродвигателя, позволивших совершить так называемый второй этап промышленной революции"),
        Friends(name: "Генри Форд", mainPic: "ford1", pics: [FriendImages(name: "ford1"), FriendImages(name: "ford2"), FriendImages(name: "ford3"), FriendImages(name: "ford4")], about: "Ге́нри Форд (англ. Henry Ford; 30 июля 1863 — 7 апреля 1947) — американский промышленник, владелец заводов по производству автомобилей по всему миру, изобретатель, автор 161 патента США. Его лозунг — «автомобиль для всех»; завод Форда выпускал наиболее дешёвые автомобили в начале эпохи автомобилестроения. Компания «Ford Motor Company» существует по сей день."),
        Friends(name: "Стив Джобс", mainPic: "jobs1", pics: [FriendImages(name: "jobs1"), FriendImages(name: "jobs2"), FriendImages(name: "jobs3")], about: "Сти́вен Пол (Стив) Джобс (англ. Steven Paul «Steve» Jobs; 24 февраля 1955, Сан-Франциско, Калифорния, США  — 5 октября 2011, Пало-Алто, Санта-Клара, Калифорния, США) — американский предприниматель, изобретатель и промышленный дизайнер, получивший широкое признание в качестве пионера эры информационных технологий"),
        Friends(name: "Брэд Питт", mainPic: "pitt1", pics: [FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4")], about: "Уи́льям Брэ́дли Питт (англ. William Bradley Pitt; род. 18 декабря 1963, Шони, Оклахома, США) — американский актёр и кинопродюсер."),
        Friends(name: "Жюль Верн", mainPic: "verne1", pics: [FriendImages(name: "verne1"), FriendImages(name: "verne2"), FriendImages(name: "verne3")], about: "Жюль Габрие́ль Верн[7] (фр. Jules Gabriel Verne; 8 февраля 1828[1][2][3][…], Нант[5] — 24 марта 1905[1][4][3][…], Амьен[5]) — французский писатель, классик приключенческой литературы, один из основоположников жанра научной фантастики, гуманист.")
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
