//
//  UIView+Shadow.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

struct Shadow {
    let color: UIColor
    let radius: CGFloat
    let offset: (x: CGFloat, y: CGFloat)
    let opacity: Float

    static let floating: Shadow = Shadow(color: .black,
                                         radius: 6,
                                         offset: (0, 6),
                                         opacity: 0.24)
    static let small: Shadow = Shadow(color: .black,
                                      radius: 2,
                                      offset: (0, 1),
                                      opacity: 0.2)
    static let tiny: Shadow = Shadow(color: .black,
                                     radius: 1,
                                     offset: (0, 2),
                                     opacity: 0.1)
}

extension UIView {
    
    func applyShadow(style: Shadow) {
        layer.masksToBounds = false
        layer.shadowColor = style.color.cgColor
        layer.shadowRadius = style.radius
        layer.shadowOffset = CGSize(width: style.offset.x, height: style.offset.y)
        layer.shadowOpacity = style.opacity
    }
    
    func removeShadow() {
        layer.masksToBounds = true
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowRadius = 0.0
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.0
    }
}
