//
//  MainView.swift
//  VKApp
//
//  Created by Алексей Виноградов on 09.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var oneFriendPhoto = UIImageView()
    let screenSize = UIScreen.main.bounds
    var friendPhotos: [FriendPhotos?] = []
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    var currentImageIndex = Int()
    
    func setup() {
        backgroundColor = .white
        
        if !friendPhotos.indices.contains(currentImageIndex) {
            return
        }
        setupImage()
        setupButton()
        
        
    }
    
    private func setupButton() {
        addSubview(leftBtn)
        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            leftBtn.centerYAnchor.constraint(equalTo: oneFriendPhoto.centerYAnchor),
            leftBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            leftBtn.widthAnchor.constraint(equalToConstant: 40),
            leftBtn.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        leftBtn.setImage(UIImage(named: "left-arrow"), for: .normal)
        
        addSubview(rightBtn)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            rightBtn.centerYAnchor.constraint(equalTo: oneFriendPhoto.centerYAnchor),
            rightBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rightBtn.widthAnchor.constraint(equalToConstant: 40),
            rightBtn.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        rightBtn.setImage(UIImage(named: "right-arrow"), for: .normal)
        
        rightBtn.addTarget(self, action: #selector(pressedRight), for: .touchDown)
        leftBtn.addTarget(self, action: #selector(pressedLeft), for: .touchDown)
        
        if currentImageIndex == 0 {
            leftBtn.alpha = 0.2
        }
        if currentImageIndex == friendPhotos.count - 1 {
            rightBtn.alpha = 0.2
        }
    }
    
    @objc func pressedRight() {
        if friendPhotos.indices.contains(currentImageIndex + 1) {
            leftBtn.alpha = 1.0
            currentImageIndex += 1
            animateToLeft()
            if currentImageIndex == friendPhotos.count - 1 {
                rightBtn.alpha = 0.2
            }
        }
        
    }
    
    @objc func pressedLeft() {
        
        if friendPhotos.indices.contains(currentImageIndex - 1) {
            rightBtn.alpha = 1.0
            currentImageIndex -= 1
            animateToRight()
            if currentImageIndex == 0 {
                leftBtn.alpha = 0.2
            }
        }
        
    }
    
    private func setupImage() {
        
        addSubview(oneFriendPhoto)
        oneFriendPhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            oneFriendPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            oneFriendPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            oneFriendPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            oneFriendPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)
            
        ])
        oneFriendPhoto.load(url: URL(string: friendPhotos[currentImageIndex]!.photo_2560)!)
        
    }
    
    private func animateToLeft() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.oneFriendPhoto.center = CGPoint(x: self.oneFriendPhoto.bounds.midX - 100, y: self.oneFriendPhoto.bounds.midY)
            self.oneFriendPhoto.alpha = 0.0
            self.oneFriendPhoto.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            self.oneFriendPhoto.load(url: URL(string: self.friendPhotos[self.currentImageIndex]!.photo_2560)!)
            self.oneFriendPhoto.center = CGPoint(x: self.screenSize.midX, y: self.screenSize.midY)
            UIView.animate(withDuration: 0.2, animations: {
                self.oneFriendPhoto.alpha = 1.0
                self.oneFriendPhoto.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
        })
        
    }
    
    private func animateToRight() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.oneFriendPhoto.center = CGPoint(x: self.oneFriendPhoto.bounds.midX + 100, y: self.oneFriendPhoto.bounds.midY)
            self.oneFriendPhoto.alpha = 0.0
            self.oneFriendPhoto.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            //self.oneFriendPhoto.image = UIImage(named: self.friendPhotos[self.currentImageIndex]?.name ?? "")
            self.oneFriendPhoto.load(url: URL(string: self.friendPhotos[self.currentImageIndex]!.photo_2560)!)
            self.oneFriendPhoto.center = CGPoint(x: self.screenSize.midX, y: self.screenSize.midY)
            UIView.animate(withDuration: 0.2, animations: {
                self.oneFriendPhoto.alpha = 1.0
                self.oneFriendPhoto.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
        })
        
    }
    
}
