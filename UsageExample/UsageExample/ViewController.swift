//
//  ViewController.swift
//  UsageExample
//
//  Created by Juan Cruz Guidi on 11/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit
import AnimatedTabBar

final class ExampleTabBarController: AnimatedTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedTabBarControllerDataSource = self
        animatedTabBarControllerDelegate = self
    }
}

extension ExampleTabBarController: AnimatedTabBarControllerDataSource {
    func tabBarControllerViewControllers() -> [AnimatedTabBarProtocol] {
        [ViewControllerOne(), ViewControllerTwo(), ViewControllerThree(), ViewControllerFour()]
    }
    func tabBarBackgroundColor() -> UIColor {
        .white
    }
    func tabBarHeight() -> CGFloat {
        45
    }
    func tabBatItemsColors() -> TabBarItemColors {
        TabBarItemColors(selected: .blue, common: UIColor.gray.withAlphaComponent(0.5))
    }
}

extension ExampleTabBarController: AnimatedTabBarControllerDelegate{
    func tabBar(_ tabBarController: AnimatedTabBarController, didSelectIndex index: Int) {
        print("Selected: \(index)")
    }
}

final class ViewControllerOne: AnimatedTabBarProtocol {
    func animatedTabBarItem() -> UITabBarItem {
        let item = UITabBarItem()
        item.selectedImage = UIImage(systemName: "pencil.slash")
        item.title = "First"
        item.image = UIImage(systemName: "pencil.slash")
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

final class ViewControllerTwo: AnimatedTabBarProtocol {
    func animatedTabBarItem() -> UITabBarItem {
        let item = UITabBarItem()
        
        item.selectedImage = UIImage(systemName: "pencil")
        item.title = "Second"
        item.image = UIImage(systemName: "pencil")
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

final class ViewControllerThree: AnimatedTabBarProtocol {
    func animatedTabBarItem() -> UITabBarItem {
        let item = UITabBarItem()
        
        item.image = UIImage(systemName: "app")
        item.selectedImage = UIImage(systemName: "app.fill")
        item.title = "Third"
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

final class ViewControllerFour: AnimatedTabBarProtocol {
    func animatedTabBarItem() -> UITabBarItem {
        let item = UITabBarItem()
        
        item.image = UIImage(systemName: "flame")
        item.selectedImage = UIImage(systemName: "flame.fill")
        item.title = "Fourth"
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
