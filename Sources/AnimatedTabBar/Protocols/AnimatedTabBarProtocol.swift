//
//  AnimatedTabBarProtocol.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

public typealias AnimatedTabBarProtocol = AnimatedTabBarViewController & UIViewController

public protocol AnimatedTabBarViewController {
    func animatedTabBarItem() -> UITabBarItem
}
