//
//  AnimatedTabBarItemable.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

public typealias AnimatedTabBarContainer = UIView & AnimatedTabBarItemable

public protocol AnimatedTabBarItemable {
    func configure(withTabBarItem item: UITabBarItem, colors: TabBarItemColors)
    func setState(isSelected: Bool)
}
