//
//  AnimatedTabBar.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

final class AnimatedTabBar : UIView {
    
    //MARK:- Public Properties
    weak var animatedTabBarDelegate: AnimatedTabBarDelegate? {
        didSet {
            self.changeIconState(forIndex: self.initialIndex, isInitial: true)
        }
    }
    
    weak var animatedTabBarDataSource: AnimatedTabBarDataSource? {
        didSet {
            self.configure()
        }
    }
    
    //MARK:- Private Properties
    private(set) var tabBarItems = [UITabBarItem]()
    private(set) var selectedIndex: Int = 0
    private(set) var initialIndex: Int = 0
    private(set) var containerWidth: CGFloat = 0
    private(set) var itemColors: TabBarItemColors
    private var animatedTabBarItems = [AnimatedTabBarContainer]()
    
    //MARK:- Initialiser
    init(withInitialIndex initialIndex: Int,
         backgroundColor: UIColor,
         itemColors: TabBarItemColors) {
        self.initialIndex = initialIndex
        self.selectedIndex = initialIndex
        self.itemColors = itemColors
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: rect.width, height: 0.5)
        borderLayer.backgroundColor = adapted(color: backgroundColor).cgColor
        layer.addSublayer(borderLayer)
    }
}

private extension AnimatedTabBar {
    func configure() {
        guard let dataSource = animatedTabBarDataSource else { return }
        tabBarItems = dataSource.animatedTabBarItems()
        
        let containerRects = createContainerRects()
        createTabBarItems(usingContainerRects: containerRects)
    }
    
    func createContainerRects() -> [CGRect] {
        var rects = [CGRect]()
        for (index, _) in tabBarItems.enumerated() {
            let containerRect = createTabBarItemContainerRect(atIndex: index)
            rects.append(containerRect)
        }
        return rects
    }
    
    func createTabBarItemContainerRect(atIndex index: Int) -> CGRect {
        let containerWidth = frame.width / CGFloat(tabBarItems.count)
        let containerHeight = frame.height
        let containerRect = CGRect(x: CGFloat(index) * containerWidth,
                                   y: 0,
                                   width: containerWidth,
                                   height: containerHeight)
        return containerRect
    }
    
    func createTabBarItems(usingContainerRects rects: [CGRect]) {
        for (index, item) in tabBarItems.enumerated() {
            let containerRect = rects[index]
            let animatedTabBarItem = AnimatedTabBarItem(frame: containerRect)
            animatedTabBarItem.configure(withTabBarItem: item, colors: itemColors)
            animatedTabBarItems.append(animatedTabBarItem)
            let tabBarButton = UIButton(frame: containerRect)
            tabBarButton.tag = index
            tabBarButton.addTarget(self,
                                   action: #selector(touchupInsideForTabBarbutton(sender:)),
                                   for: .touchUpInside)
            addSubview(animatedTabBarItem)
            addSubview(tabBarButton)
        }
    }
    
    @objc
    func touchupInsideForTabBarbutton(sender: UIButton) {
        if selectedIndex != sender.tag {
            changeIconState(forIndex: sender.tag)
        }
    }
    
    func changeIconState(forIndex index: Int, isInitial: Bool = false) {
        animatedTabBarItems[index].setState(isSelected: true)
        if !isInitial {
            animatedTabBarItems[selectedIndex].setState(isSelected: false)
        }
        selectedIndex = index
        animatedTabBarDelegate?.didSelect(tabAtIndex: index)
    }
    
    func adapted(color: UIColor?) -> UIColor {
        guard let color = color else {
            return UIColor.lightGray.withAlphaComponent(0.5)
        }
        if color.getBrightness() < 0.5 {
            return color.lighter()
        } else {
            return color.darker()
        }
    }
}
