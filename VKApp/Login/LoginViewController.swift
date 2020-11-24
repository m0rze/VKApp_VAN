//
//  LoginViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var processBarView: ProcessBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginField.text = "admin"
        passField.text = "123456"
        animateTitleAppearing()
        animateProcessBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: Notification){
        
        guard
            let keyboardHeight = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        scrollView.contentInset.bottom = keyboardHeight.height
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if loginField.text == "admin" && passField.text == "123456"{
            
            return true
            
        }else{
            loginField.text = ""
            passField.text = ""
            
            let alert = UIAlertController(title: "Ошибка", message: "Проверьте логин или пароль", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    func animateTitleAppearing() {
        self.titleLabel.transform = CGAffineTransform(translationX: 0,
                                                      y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.titleLabel.transform = .identity
        },
                       completion: nil)
        
        
    }
    
    func animateProcessBar() {
        
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.processBarView.firstCircle.alpha = 0.0
        })
        
        UIView.animate(withDuration: 1, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            self.processBarView.secondCircle.alpha = 0.0
        })
        UIView.animate(withDuration: 1, delay: 1, options: [.autoreverse, .repeat], animations: {
            self.processBarView.thirdCircle.alpha = 0.0
        })
        
    }
    
}

