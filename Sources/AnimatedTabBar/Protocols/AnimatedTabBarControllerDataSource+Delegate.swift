//
//  AnimatedTabBarControllerDataSource+Delegate.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

public protocol AnimatedTabBarControllerDataSource: AnyObject {
    func tabBarControllerInitialIndex() -> Int
    func tabBarControllerViewControllers() -> [AnimatedTabBarProtocol]
    func tabBarHeight() -> CGFloat
    func tabBarBackgroundColor() -> UIColor
    func tabBatItemsColors() -> TabBarItemColors
}

public extension AnimatedTabBarControllerDataSource {
    func tabBarHeight() -> CGFloat { 40 }
    func tabBarControllerInitialIndex() -> Int { 0 }
}

public protocol AnimatedTabBarControllerDelegate: AnyObject {
    func tabBar(_ tabBarController: AnimatedTabBarController, didSelectIndex index: Int)
}
