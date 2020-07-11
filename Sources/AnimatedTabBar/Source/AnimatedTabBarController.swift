//
//  AnimatedTabBarController.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

open class AnimatedTabBarController: UITabBarController {
    public weak var animatedTabBarControllerDataSource: AnimatedTabBarControllerDataSource? {
        didSet {
            self.configureViews()
        }
    }
    
    public weak var animatedTabBarControllerDelegate: AnimatedTabBarDelegate?
    private var animatedTabBar: AnimatedTabBar!
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func willTransition(to newCollection: UITraitCollection,
                                      with coordinator: UIViewControllerTransitionCoordinator) {
        animatedTabBar.setNeedsDisplay()
    }
}

private extension AnimatedTabBarController {
    func configureViews() {
        guard let dataSource = animatedTabBarControllerDataSource else { return }
        tabBar.isHidden = true
        viewControllers = dataSource.tabBarControllerViewControllers()
        animatedTabBar = AnimatedTabBar(withInitialIndex: dataSource.tabBarControllerInitialIndex(),
                              backgroundColor: dataSource.tabBarBackgroundColor(),
                              itemColors: dataSource.tabBatItemsColors())
        view.addSubview(animatedTabBar)
        setupConstraints(withHeight: dataSource.tabBarHeight())
        
        animatedTabBar.animatedTabBarDataSource = self
        animatedTabBar.animatedTabBarDelegate = self
    }
    
    func setupConstraints(withHeight height: CGFloat) {
        animatedTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animatedTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animatedTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animatedTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: animatedTabBar.topAnchor, constant: height)
        ])
        view.layoutIfNeeded()
    }
}

extension AnimatedTabBarController: AnimatedTabBarDelegate, AnimatedTabBarDataSource {
    public func didSelect(tabAtIndex index: Int) {
        selectedIndex = index
    }
    
    public func animatedTabBarItems() -> [UITabBarItem] {
        guard let dataSource = animatedTabBarControllerDataSource else { fatalError() }
        return dataSource.tabBarControllerViewControllers().map { $0.animatedTabBarItem() }
    }
}
