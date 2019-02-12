//
//  AppCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit


class ApplicationCoordinator: ParentCoordinator {
    
    let appContext: AppContext
    let window: UIWindow
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        appContext = AppContext()
        navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let homeCoordinator = HomeCoordinator(presenter: navigationController, context: appContext)
        add(childCoordinator: homeCoordinator)
    }
}
