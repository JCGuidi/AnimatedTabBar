//
//  AnimatedTabBarDataSource+Delegate.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

public protocol AnimatedTabBarDelegate: AnyObject {
    func didSelect(tabAtIndex index: Int)
}

public protocol AnimatedTabBarDataSource: AnyObject {
    func animatedTabBarItems() -> [UITabBarItem]
}
