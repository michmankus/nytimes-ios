//
//  NewsDetailViewModel.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

protocol NewsDetailViewModelCoordinatorDelegate: class {
    func close()
}

class NewsDetailViewModel {
    
    private let articleData: ArticleData
    var headerImageHeroID: String {
        return AnimationConstants.HeroIdentifiers.newsImage + "\(articleData.id)"
    }
    var headerImageURL: URL? {
        return articleData.media.first?.mediaMetadata.first?.url //TODO: Add carousel
    }
    var titleText: String {
        return articleData.title
    }
    var titleLabelHeroID: String {
        return AnimationConstants.HeroIdentifiers.newsTitle + "\(articleData.id)"
    }
    var articleText: String {
        return articleData.abstract //There is no content data and API doesn't provide endpoint for fetching content
    }
    
    weak var coordinatorDelegate: NewsDetailViewModelCoordinatorDelegate?
    
    func closeButtonAction() {
        coordinatorDelegate?.close()
    }
    
    init(articleData: ArticleData) {
        self.articleData = articleData
    }
}
