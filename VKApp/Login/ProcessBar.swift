//
//  ProcessBar.swift
//  VKApp
//
//  Created by Алексей Виноградов on 06.09.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

@IBDesignable
class ProcessBar: UIView {
    
    var firstCircle = UIView()
    var secondCircle = UIView()
    var thirdCircle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)!
    }
    
    private func setup() {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = 15
        setupFirstCircle()
        setupSecondCircle()
        setupThirdCircle()
    }
    
    private func setupFirstCircle(){

        firstCircle.layer.cornerRadius = 7.5
        addSubview(firstCircle)
        firstCircle.backgroundColor = .yellow
        
        firstCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            firstCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            firstCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            firstCircle.widthAnchor.constraint(equalToConstant: 15),
            firstCircle.heightAnchor.constraint(equalToConstant: 15)
            
        ])
        
        
    }
    
    private func setupSecondCircle(){
        
        secondCircle.layer.cornerRadius = 7.5
        
        addSubview(secondCircle)
        secondCircle.backgroundColor = .yellow
        
        secondCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            secondCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondCircle.widthAnchor.constraint(equalToConstant: 15),
            secondCircle.heightAnchor.constraint(equalToConstant: 15)
            
        ])
        
    }
    
    private func setupThirdCircle(){
        
        thirdCircle.layer.cornerRadius = 7.5
        
        addSubview(thirdCircle)
        thirdCircle.backgroundColor = .yellow
        
        thirdCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            thirdCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            thirdCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            thirdCircle.widthAnchor.constraint(equalToConstant: 15),
            thirdCircle.heightAnchor.constraint(equalToConstant: 15)
            
        ])
        
    }
    
}
