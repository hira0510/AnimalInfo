//
//  AnimalInfoMainTabController.swift
//  AnimalInfo
//
//  Created by  on 2021/7/29.
//

import UIKit

class AnimalInfoMainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension AnimalInfoMainTabController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
}
