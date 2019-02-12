//
//  NewsDetailCoordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class NewsDetailCoordinator: ChildCoordinator {
    
    let appContext: AppContext
    let presenter: UIViewController
    weak var parentCoordinator: ParentCoordinator?
    private let newsDetailViewModel: NewsDetailViewModel
    private let newsDetailViewController: NewsDetailViewController
    
    func start() {
        presenter.present(newsDetailViewController, animated: true)
        newsDetailViewModel.coordinatorDelegate = self
    }
    
    init(presenter: UIViewController, context: AppContext, articleData: ArticleData) {
        self.presenter = presenter
        self.appContext = context
        
        newsDetailViewModel = NewsDetailViewModel(articleData: articleData)
        newsDetailViewController = NewsDetailViewController(viewModel: newsDetailViewModel)
    }
}

extension NewsDetailCoordinator: NewsDetailViewModelCoordinatorDelegate {
    func close() {
        presenter.dismiss(animated: true, completion: nil)
        removeFromParentCoordinator()
    }
}
