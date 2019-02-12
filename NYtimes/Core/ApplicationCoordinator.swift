//
//  AppCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit


class ApplicationCoordinator: Coordinator {
    let appContext: AppContext
    let window: UIWindow
    let rootViewController: UIViewController
    
    init(window: UIWindow) {
        self.window = window
        appContext = AppContext()
        
        let homeViewModel = HomeViewModel(mostViewedApiClient: appContext.mostViewedApiClient)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        rootViewController = navigationController
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
