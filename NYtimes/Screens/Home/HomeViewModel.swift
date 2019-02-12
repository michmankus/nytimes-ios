//
//  HomeViewModel.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

protocol HomeViewModelViewDelegate: class {
    func dataLoaded()
    func busy()
    func idle()
}

protocol HomeViewModelCoordinatorDelegate: class {
    
}

class HomeViewModel {
    
    private let apiClient: MostViewedApiClient
    private var articles: [ArticleData] = []
    
    weak var viewDelegate: HomeViewModelViewDelegate?
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return articles.count
    }
    
    func itemModel(at index: IndexPath) -> NewsCellModel {
        let article = articles[index.row]
        let imageUrls: [URL] = article.media.first?.mediaMetadata.map {
            $0.url
        } ?? []
        let model = NewsCellModel(url: article.url, title: article.title, imageUrls: imageUrls)
        return model
    }
    
    func loadData() {
        viewDelegate?.busy()
        apiClient.fetchMostViewed() { [weak self] result in
            guard let self = self else { return }
            
            self.viewDelegate?.idle()
            switch result {
            case .success(let data):
                self.articles = data.results
                self.viewDelegate?.dataLoaded()
            case .failure(let error):
                break
            }
        }
    }
    
    init(mostViewedApiClient: MostViewedApiClient) {
        self.apiClient = mostViewedApiClient
    }
}
