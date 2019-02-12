//
//  HomeViewModel.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

protocol HomeViewModelViewDelegate: class {
    func dataLoaded()
    func busy()
    func idle()
}

protocol HomeViewModelCoordinatorDelegate: class {
    func openArticle(data: ArticleData)
}

class HomeViewModel {
    
    private let apiClient: MostViewedApiClient
    private var articles: [ArticleData] = []
    lazy var titleView: UIView = {
        let image = UIImage(named: "nytimes-logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(imageView)
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, topConstant: 10, leftConstant: 50,
                         bottomConstant: 10, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        return view
    }()
    
    weak var viewDelegate: HomeViewModelViewDelegate?
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return articles.count
    }
    
    private func article(at indexPath: IndexPath) -> ArticleData {
        return articles[indexPath.row]
    }
    
    func itemModel(at indexPath: IndexPath) -> NewsCellModel {
        let articleData = article(at: indexPath)
        let imageUrls: [URL] = articleData.media.first?.mediaMetadata.map {
            $0.url
        } ?? []
        let model = NewsCellModel(url: articleData.url, title: articleData.title, imageUrls: imageUrls, articleID: articleData.id)
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
    
    func didSelectCell(at indexPath: IndexPath) {
        let articleData = article(at: indexPath)
        coordinatorDelegate?.openArticle(data: articleData)
    }
    
    init(mostViewedApiClient: MostViewedApiClient) {
        self.apiClient = mostViewedApiClient
    }
}
