//
//  AnimatedTabBarItem.swift
//  AnimatedTabBar
//
//  Created by Juan Cruz Guidi on 05/07/2020.
//  Copyright © 2020 Juan Cruz Guidi. All rights reserved.
//

import UIKit

final class AnimatedTabBarItem: AnimatedTabBarContainer {
    
    private var iconView: UIImageView!
    private var defaultImage: UIImage!
    private var selectedImage: UIImage!
    private var titleLabel: UILabel!
    private var selectedColor: UIColor!
    private var commonColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure(withTabBarItem item: UITabBarItem, colors: TabBarItemColors) {
        guard let image = item.image else {
            fatalError("no image set")
        }
        selectedColor = colors.selected
        commonColor = colors.common
        defaultImage = image
        selectedImage = item.selectedImage
        let rect = CGRect(x: (frame.width - defaultImage.size.width) / 2,
                          y: (frame.height - defaultImage.size.height) / 2,
                          width: frame.width,
                          height: frame.height)
        iconView = UIImageView(frame: rect)
        iconView.image = defaultImage
        iconView.tintColor = commonColor
        iconView.alpha = 0.5
        iconView.sizeToFit()
        addSubview(iconView)
        
        let labelRect = CGRect(x: 0,
                               y: (frame.height - 15),
                               width: frame.width,
                               height: 10)
        titleLabel = UILabel(frame: labelRect)
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.text = item.title
        titleLabel.textAlignment = .center
        titleLabel.isHidden = true
        titleLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        addSubview(titleLabel)
    }
    
    func setState(isSelected: Bool) {
        if isSelected {
            animateIn()
            guard let selectedImage = selectedImage else { return }
            iconView.image = selectedImage
        } else {
            iconView.image = defaultImage
            animateOut()
        }
    }
    
    func animateOut() {
        titleLabel.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.3, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.titleLabel.alpha = 0
            self.iconView.tintColor = self.commonColor
            self.iconView.layer.position.y += 5
        }) { (completed) in
            if completed {
                self.titleLabel.isHidden = true
            }
        }
    }
    
    func animateIn() {
        titleLabel.isHidden = false
        titleLabel.layer.removeAllAnimations()
        titleLabel.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.titleLabel.transform = .identity
            self.titleLabel.alpha = 1
            self.titleLabel.textColor = self.selectedColor
            self.iconView.tintColor = self.selectedColor
            self.iconView.alpha = 1
            self.iconView.layer.position.y -= 5
        }){ (completed) in
            self.titleLabel.isHidden = false
        }
    }
}
