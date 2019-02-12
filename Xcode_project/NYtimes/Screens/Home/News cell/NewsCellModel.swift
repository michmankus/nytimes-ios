//
//  NewsCellModel.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

struct NewsCellModel {
    let url: URL?
    let title: String
    let imageUrls: [URL]
    let articleID: Int
    var newsImageHeroID: String {
        return AnimationConstants.HeroIdentifiers.newsImage + "\(articleID)"
    }
    var newsTitleHeroID: String {
        return AnimationConstants.HeroIdentifiers.newsTitle + "\(articleID)"
    }
}
