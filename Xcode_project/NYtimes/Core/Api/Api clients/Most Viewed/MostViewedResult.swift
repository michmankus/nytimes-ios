//
//  MostViewedResult.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

struct MediaMetadata: Codable {
    let url: URL
    let format: String?
    let height: Int
    let width: Int
}

struct ArticleMedia: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case mediaMetadata = "media-metadata"
    }
    
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approved_for_syndication: Int
    let mediaMetadata: [MediaMetadata]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        approved_for_syndication = try values.decode(Int.self, forKey: .approved_for_syndication)
        mediaMetadata = try values.decode([MediaMetadata].self, forKey: .mediaMetadata)
    }
}

struct ArticleData: Codable {
    let url: URL?
    let column: String?
    let section: String?
    let type: String?
    let title: String
    let abstract: String
    let published_date: String
    let source: String
    let id: Int
    let views: Int
    let media: [ArticleMedia]
}

struct MostViewedResult: Codable {
    let status: String
    let copyright: String
    let num_results: Int
    let results: [ArticleData]
}
