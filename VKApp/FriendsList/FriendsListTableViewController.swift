//
//  FriendsListTableViewController.swift
//  VKApp
//
//  Created by Алексей Виноградов on 18.08.2020.
//  Copyright © 2020 Алексей Виноградов. All rights reserved.
//

import UIKit

struct FriendsFullData {
    let letter: String?
    let friendData: [Friends]
}

class FriendsListTableViewController: UITableViewController, UISearchBarDelegate, UINavigationControllerDelegate {
    
    let myFriends = [
        Friends(name: "Никола Тесла", mainPic: "tesla1", pics: [FriendImages(name: "tesla1"), FriendImages(name: "tesla2"), FriendImages(name: "tesla3")], about: nil),
        Friends(name: "Генри Форд", mainPic: "ford1", pics: [FriendImages(name: "ford1"), FriendImages(name: "ford2"), FriendImages(name: "ford3"), FriendImages(name: "ford4")], about: nil),
        Friends(name: "Стив Джобс", mainPic: "jobs1", pics: [FriendImages(name: "jobs1"), FriendImages(name: "jobs2"), FriendImages(name: "jobs3")], about: nil),
        Friends(name: "Брэд Питт", mainPic: "pitt1", pics: [FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4"), FriendImages(name: "pitt1"), FriendImages(name: "pitt2"), FriendImages(name: "pitt3"), FriendImages(name: "pitt4")], about: nil),
        Friends(name: "Жюль Верн", mainPic: "verne1", pics: [FriendImages(name: "verne1"), FriendImages(name: "verne2"), FriendImages(name: "verne3")], about: nil)
    ]
    
    var searchedFriends: [Friends] = []
    
    var sortedFriendsData: [FriendsFullData] = []
    
    var rootFriendIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        searchedFriends = myFriends
        let searchBar: UISearchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Поиск..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        tableView.backgroundColor = #colorLiteral(red: 0.02839463949, green: 0.8947911859, blue: 1, alpha: 1)
        tableView.register(UINib(nibName: "FriendsHeaderCell", bundle: .none), forHeaderFooterViewReuseIdentifier: "FriendCell")
        
        sortedFriendsData = map(friends: searchedFriends)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            searchedFriends = myFriends
        } else {
            
            searchedFriends = myFriends.filter({ (friend) -> Bool in
                return friend.name.contains(text)
            })
        }
        sortedFriendsData = map(friends: searchedFriends)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedFriendsData[section].friendData.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendCell") as! FriendsHeaderCell
        
        let headerTitle = sortedFriendsData[section].letter
        view.headerLabel.text = headerTitle
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    private func map(friends: [Friends]) -> [FriendsFullData] {
        
        var outputFriends: [FriendsFullData] = []
        
        let sortedFriends = friends.sorted{(u1, u2) -> Bool in u1.name < u2.name}
        
        var lastOfLetter: String = ""
        var friendsOfLetter: [Friends] = []
        var i: Int = 0
        for oneFriend in sortedFriends {
            i += 1
            if lastOfLetter == "" {
                lastOfLetter = oneFriend.firstLetter
            }
            
            if lastOfLetter == oneFriend.firstLetter {
                friendsOfLetter.append(oneFriend)
            } else {
                outputFriends.append(FriendsFullData(letter: lastOfLetter, friendData: friendsOfLetter))
                friendsOfLetter = []
                friendsOfLetter.append(oneFriend)
                
            }
            
            if i == sortedFriends.count {
                outputFriends.append(FriendsFullData(letter: oneFriend.firstLetter, friendData: friendsOfLetter))
            }
            lastOfLetter = oneFriend.firstLetter
            
        }
        
        return outputFriends
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! FriendsOneCellController
        
        let currentFriend = sortedFriendsData[indexPath.section].friendData[indexPath.row]
        cell.configCell(oneFriend: currentFriend)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.rootFriendIndex = indexPath.row
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "FriendsPhotoCollectionViewControllerID") as! FriendsPhotoCollectionViewController
        vc.friendsPhotos = sortedFriendsData[indexPath.section].friendData[indexPath.row].pics
        
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedFriendsData.count
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
