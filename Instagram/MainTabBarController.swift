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

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {
    var userProfileNavController:UINavigationController?
    var homeNavController:UINavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectorController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            
            return false
        } else {
            return true
        }
    }
        func setupViewControllers() {
            //home
            let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
            // search
            let searchNavController = templateNavController(unselectedImage:#imageLiteral(resourceName: "search_unselected")  , selectedImage: #imageLiteral(resourceName: "search_selected"))
            let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
            let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
            //userProfile
            let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
            tabBar.tintColor = .black
//            let layout = UICollectionViewFlowLayout()
//            let userProfileController = UserProfileController(collectionViewLayout: layout)
//             userProfileNavController = UINavigationController(rootViewController: userProfileController)
//            userProfileNavController?.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
//            userProfileNavController?.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
//            tabBar.tintColor = .black
            viewControllers = [homeNavController, searchNavController,plusNavController, likeNavController,userProfileNavController ]
            guard let items = tabBar.items else { return }
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4 , right: 0)
            }

            if Auth.auth().currentUser == nil {
                print("No User")
                DispatchQueue.main.async {
                    
                let loginController = LoginController()
                loginController.modalPresentationStyle = .fullScreen
                let navController = UINavigationController(rootViewController: loginController)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
            }
            }
        }
        fileprivate func templateNavController(unselectedImage:UIImage,selectedImage:UIImage , rootViewController : UIViewController = UIViewController() ) -> UINavigationController {
            
            let viewController = rootViewController
            self.navigationController?.popToRootViewController(animated: true)
            self.navigationController?.pushViewController(viewController, animated: true)
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem.image = unselectedImage
            navController.tabBarItem.selectedImage = selectedImage
            return navController
        }
}

