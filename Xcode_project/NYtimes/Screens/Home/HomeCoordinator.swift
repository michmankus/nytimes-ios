//
//  HomeCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class HomeCoordinator: ParentCoordinator, ChildCoordinator {
    
    let appContext: AppContext
    let presenter: UINavigationController
    weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [Coordinator] = []
    private let homeViewController: HomeViewController
    private let homeViewModel: HomeViewModel
    
    func start() {
        presenter.setViewControllers([homeViewController], animated: false)
        homeViewModel.coordinatorDelegate = self
    }
    
    init(presenter: UINavigationController, context: AppContext) {
        self.appContext = context
        self.presenter = presenter
        
        self.homeViewModel = HomeViewModel(mostViewedApiClient: appContext.mostViewedApiClient)
        self.homeViewController = HomeViewController(viewModel: homeViewModel)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func openArticle(data: ArticleData) {
        let coordinator = NewsDetailCoordinator(presenter: presenter, context: appContext, articleData: data)
        add(childCoordinator: coordinator)
    }
}
