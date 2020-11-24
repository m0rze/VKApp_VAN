//
//  NewsCell.swift
//  VKApp
//
//  Created by Алексей Виноградов on 03.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var postFriendAvatar: UIImageView!
    @IBOutlet weak var postFriendName: UILabel!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    
    
    var likeTrigger: Int?
    let btn = UIButton(type: .custom)
    let btnComment = UIButton(type: .custom)
    let btnSayOther = UIButton(type: .custom)
    let likeLabel: UILabel = UILabel()
    var likesCountUp: () -> Void? = {}
    var likesCountDown: () -> Void? = {}
    var likesStateUp: () -> Void? = {}
    var likesStateDown: () -> Void? = {}
    
    func configCell(currentFriend: Friends){
        postFriendName.text = currentFriend.name
        postText.text = currentFriend.about
        postImage.image = UIImage(named: currentFriend.mainPic)
        avatarImage(imgname: currentFriend.mainPic)
        likeTrigger = currentFriend.friendLikeState
        likeLabel.text = "\(currentFriend.friendLikes)"
        if likeTrigger == 1 {
            btn.setImage(UIImage(named: "like_heart"), for: .normal)
            likeLabel.textColor = .systemGreen
        } else {
            btn.setImage(UIImage(named: "heart"), for: .normal)
            likeLabel.textColor = .red
        }
    }
    
    func avatarImage(imgname: String){
        let background = UIImage(named: imgname)
        
        if let imageView = postFriendAvatar {
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = center
            let roundMask = CAShapeLayer()
            roundMask.path = UIBezierPath(ovalIn: imageView.bounds).cgPath
            imageView.layer.mask = roundMask
        }
        setupView()
    }
    
    func setupView() {
        
        btn.addTarget(self, action: #selector(addLike), for: .touchUpInside)
        addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            btn.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 2),
            btn.widthAnchor.constraint(equalToConstant: 20),
            btn.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        likeLabel.frame = CGRect(x: btn.bounds.maxX + 5, y: btn.bounds.minY + 5, width: 30, height: 30)
        likeLabel.font = likeLabel.font.withSize(20)
        likeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        addSubview(likeLabel)
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.leadingAnchor.constraint(equalTo: btn.trailingAnchor, constant: 5),
            likeLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 5),
            likeLabel.widthAnchor.constraint(equalToConstant: 10),
            likeLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        btnSayOther.setTitle("Поделиться", for: .normal)
        btnSayOther.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btnSayOther.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        addSubview(btnSayOther)
        btnSayOther.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnSayOther.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 5),
            btnSayOther.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 5),
            btnSayOther.widthAnchor.constraint(equalToConstant: 80),
            btnSayOther.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        btnComment.setTitle("Комментировать", for: .normal)
        btnComment.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btnComment.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        addSubview(btnComment)
        btnComment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnComment.leadingAnchor.constraint(equalTo: btnSayOther.trailingAnchor, constant: 5),
            btnComment.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 5),
            btnComment.widthAnchor.constraint(equalToConstant: 120),
            btnComment.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    @objc
    func addLike(){
        
        if likeTrigger == 0 {
            btn.setImage(UIImage(named: "like_heart"), for: .normal)
            likesCountUp()
            likesStateUp()
            likeLabel.text = "1"
            likeLabel.textColor = .systemGreen
        }else if likeTrigger == 1 {
            
            btn.setImage(UIImage(named: "heart"), for: .normal)
            likesCountDown()
            likesStateDown()
            likeLabel.text = "0"
            likeLabel.textColor = .red
            
        }
    }
}
