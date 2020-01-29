//
//  MainTabBarController.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    func setupViewControllers() {
        //home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        // search
        let searchNavController = templateNavController(unselectedImage:#imageLiteral(resourceName: "search_unselected")  , selectedImage: #imageLiteral(resourceName: "search_selected"))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        //userProfile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userProfileNavController = UINavigationController(rootViewController: userProfileController)
        
            if Auth.auth().currentUser == nil {
                let loginController = LoginController()
                userProfileNavController.pushViewController(loginController, animated: true)
            }
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        tabBar.tintColor = .black
        viewControllers = [homeNavController, searchNavController,plusNavController, likeNavController,userProfileNavController]
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4 , right: 0)
        }
}
    fileprivate func templateNavController(unselectedImage:UIImage,selectedImage:UIImage , rootViewController : UIViewController = UIViewController() ) -> UINavigationController {
        let viewController = rootViewController
               let navController = UINavigationController(rootViewController: viewController)
               navController.tabBarItem.image = unselectedImage
               navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
