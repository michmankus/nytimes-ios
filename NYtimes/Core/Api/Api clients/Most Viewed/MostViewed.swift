//
//  ApiClient+MostViewed.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

class MostViewedApiClient: ApiClient {
    
    enum Period: Int {
        case day = 1
        case week = 7
        case month = 30
    }
    
    enum MostViewedSection: String {
        case all = "all-sections"
    }
    
    func fetchMostViewed(section: MostViewedSection = .all,
                         period: Period = .week,
                         completion: @escaping (RequestResult<MostViewedResult>) -> Void) {
        let endpoint = "mostviewed/" + section.rawValue + "/\(period.rawValue)" + ".json"
        fetchJSONData(endpoint: endpoint, expectedType: MostViewedResult.self, completion: completion)
    }
    
    override init(networkService: NetworkServiceProtocol) {
        super.init(networkService: networkService)
    }
}
