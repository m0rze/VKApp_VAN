//
//  FriendsListTableViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit
import RealmSwift

struct FriendsFullData {
    let letter: String?
    let friendData: [FriendsData]
}

class FriendsListTableViewController: UITableViewController, UISearchBarDelegate, UINavigationControllerDelegate {
    
    //var friends: [FriendsData] = []
    var friends: Results<FriendsData>!
    let userSession = UserSessions.instance
    
    var searchedFriends: [FriendsData] = []
    
    var sortedFriendsData: [FriendsFullData] = []
    
    var rootFriendIndex: Int? = nil
    
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.getFriendsAndObserve()
        //self.sorteredFriends()
        
    }
    
    func getFriendsAndObserve() {
        
        self.friends = RealmActions.shared.loadRealmFriends()
        
        token = friends?.observe(on: DispatchQueue.main, { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .update(_, let deletions, let insertions, let modifications):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
            case .initial:
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
                
            }
            
        })
        
        VKGetData.shared.getFriendsList(completion: {})
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! FriendsOneCellController
        
       // let currentFriend = sortedFriendsData[indexPath.section].friendData[indexPath.row]
        let currentFriend = friends[indexPath.row]
        cell.configCell(oneFriend: currentFriend)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.rootFriendIndex = indexPath.row
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "FriendsPhotoCollectionViewControllerID") as! FriendsPhotoCollectionViewController
        vc.friendIndex = friends[indexPath.row].id
        
        self.navigationController?.pushViewController(vc, animated:true)
        
    }

    
    func navigationController(_ navigationController: UINavigationController,animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        
        return nil
        
    }
    
    let interactiveTransition = CustomInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
}

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceVC = transitionContext.viewController(forKey: .from)!
        let destinationVC = transitionContext.viewController(forKey: .to)!
        
        
        let firstRotation = CATransform3DMakeRotation(90.0 / 180.0 * .pi, 0.0, 0.0, 1.0)
        let finishRotation = CATransform3DMakeRotation(0, 0.0, 0.0, 0.0)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationVC.view)
        destinationVC.view.frame.origin.x = containerView.frame.midX - destinationVC.view.frame.height / 2
        destinationVC.view.frame.origin.y = 0 - containerView.frame.height
        destinationVC.view.transform = CATransform3DGetAffineTransform(firstRotation)
        
        UIView.animate(withDuration: 1.0, animations: {
            
            destinationVC.view.transform = CATransform3DGetAffineTransform(finishRotation)
            destinationVC.view.center = containerView.center
            
        }, completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                sourceVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
        
    }
    
}

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceVC = transitionContext.viewController(forKey: .from)!
        let destinationVC = transitionContext.viewController(forKey: .to)!
        
        
        let finishRotation = CATransform3DMakeRotation(90.0 / 180.0 * .pi, 0.0, 0.0, 1.0)
        
        let containerView = transitionContext.containerView
        transitionContext.containerView.addSubview(destinationVC.view)
        transitionContext.containerView.sendSubviewToBack(destinationVC.view)
        
        UIView.animate(withDuration: 1.0, animations: {
            
            sourceVC.view.transform = CATransform3DGetAffineTransform(finishRotation)
            sourceVC.view.frame.origin.x = containerView.frame.midX - sourceVC.view.frame.height / 2
            sourceVC.view.frame.origin.y = 0 - containerView.frame.height
            
        }, completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                sourceVC.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destinationVC.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        })
        
    }
    
}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.33
            
            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
    
}
