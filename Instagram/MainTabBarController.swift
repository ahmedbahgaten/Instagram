//
//  MainTabBarController.swift
//  Instagram
//
//  Created by AHMED on 1/13/20.
//  Copyright © 2020 AHMED. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController)
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        tabBar.tintColor = .black
        viewControllers = [navController,UIViewController()]
    }
}
