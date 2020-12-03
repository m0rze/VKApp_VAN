//
//  AvatarView.swift
//  VKApp
//
//  Created by Алексей Виноградов on 26.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit


class AvatarView: UIView {
    
    @IBInspectable var shadowRadius: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var scaleAvatar: CGAffineTransform
    
    override init(frame: CGRect) {
        scaleAvatar = CGAffineTransform(scaleX: 1.1, y: 1.1)
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder){
        scaleAvatar = CGAffineTransform(scaleX: 1.1, y: 1.1)
        super.init(coder: coder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func avatarImage(imgname: URL){

        var imageView : UIImageView!
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width-10, height: frame.height-10))
        
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.load(url: imgname)
        imageView.center = center
        let roundMask = CAShapeLayer()
        roundMask.path = UIBezierPath(ovalIn: imageView.bounds).cgPath
        imageView.layer.mask = roundMask
        addSubview(imageView)
    }
    
    func shadowSubView(){
        
        let shadowView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width-10, height: frame.height-10))
        let roundMask = CAShapeLayer()
        
        shadowView.center = center
        shadowView.frame = CGRect(x: shadowView.frame.minX + 5, y: shadowView.frame.minY + 5, width: frame.width-10, height: frame.height-10)
        
        roundMask.path = UIBezierPath(ovalIn: shadowView.bounds).cgPath
        shadowView.layer.mask = roundMask
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowPath = roundMask.path
        
        addSubview(shadowView)
        bringSubviewToFront(shadowView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateAvatar()
    }
    
    private func animateAvatar(){
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.3, options: [], animations: {
            
            self.transform = self.scaleAvatar
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.scaleAvatar = CGAffineTransform(scaleX: 1, y: 1)
                self.transform = self.scaleAvatar
            })
        })
        
    }
    
}


