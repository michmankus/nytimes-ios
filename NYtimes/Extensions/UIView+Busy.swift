//
//  UIView+Busy.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class ActivityIndicatorContainer: UIView {
    
    var isEnabled: Bool = false {
        didSet {
            isHidden = !isEnabled
            isEnabled ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        }
    }
    
    var isAnimating: Bool {
        return activityIndicatorView.isAnimating
    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .whiteLarge)
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        initialize()
    }
    
    private func initialize() {
        backgroundColor = ColorPallete.dimmBackground
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

protocol Busy {
    var isBusy: Bool { get set }
}

extension UIView: Busy {
    @objc var isBusy: Bool {
        get {
            if let container = activityIndicatorContainer {
                return container.isAnimating
            }
            
            return false
        }
        
        set {
            if let container = activityIndicatorContainer {
                container.isEnabled = newValue
            } else {
                let container = ActivityIndicatorContainer()
                addSubview(container)
                container.fillSuperview()
                container.isEnabled = newValue
            }
        }
    }
    
    private var activityIndicatorContainer: ActivityIndicatorContainer? {
        for view in self.subviews {
            if view.isKind(of: ActivityIndicatorContainer.self) {
                return view as? ActivityIndicatorContainer
            }
        }
        
        return nil
    }
}
