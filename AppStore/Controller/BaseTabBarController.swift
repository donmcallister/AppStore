//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Donald McAllister on 5/10/19.
//  Copyright © 2019 Donald McAllister. All rights reserved.
//

//1 - inside Controller we want a new Group: Apps:  AppsController to replace dummy controller: createNavController(viewController: --> UIViewController()<---
//2 - pop AppsController into dummy view controller and get error: 'UICollectionView must be initialized with a non-nil layout parameter'
//3 - copy in the custom initializers we did at very bottom of AppsSearchController..
//4 - further clean up code since we are repeating code.. create BaseListController.swift
//5 - and now AppsController can conform to BaseListController
//6 - can now also update AppsSearchController to conform to this BaseListController
//7 - in AppsController: register new cell, cellId, numberOfItemsInSection, cellforItemAt....lightgray background to render 5 small cells on screen...
//8 - conform to UICollectionViewDelegateFlowLayout to make cells a lot larger..
//9 - sizeForItemAt...return .init(width: view.frame.width, height: 250)
//10 - see now instruction inside AppsController

import UIKit

class BaseTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       viewControllers = [
         createNavController(viewController: AppsController(), title: "Apps", imageName: "apps"),
        createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
        createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
        ]
        
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
        
    }
}
