//
//  ParentCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

extension ParentCoordinator {
    
    func remove(childCoordinator: ChildCoordinator) {
        guard let index = self.childCoordinators.index(where: { $0 === childCoordinator }) else { return }

        childCoordinators.remove(at: index)
    }
    
    func add(childCoordinator: ChildCoordinator) {
        guard childCoordinators.index(where: { $0 === childCoordinator }) == nil else { return }
        
        childCoordinator.parentCoordinator = self
        self.childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func removeAllChildCoordinators() {
        self.childCoordinators.removeAll()
    }
}
