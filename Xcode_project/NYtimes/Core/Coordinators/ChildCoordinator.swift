//
//  ChildCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

protocol ChildCoordinator: Coordinator {
    var parentCoordinator: ParentCoordinator? { get set }
}

extension ChildCoordinator {
    
    func removeFromParentCoordinator() {
        parentCoordinator?.remove(childCoordinator: self)
    }
}

extension ChildCoordinator where Self: ParentCoordinator {
    
    func removeFromParentCoordinator() {
        removeAllChildCoordinators()
        parentCoordinator?.remove(childCoordinator: self)
    }
}
