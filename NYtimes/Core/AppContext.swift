//
//  AppContext.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

class AppContext {
    
    let mostViewedApiClient: MostViewedApiClient
    
    init() {
        let mostViewedConfig = ApiConfiguration(baseURL: "http://api.nytimes.com/svc/mostpopular/", //TODO: - Move it to some config file
                                                apiVersion: "v2",
                                                key: "YV5aKqdBRWAI2Dab3uHMKpNwHmvogGwz")
        let mostViewedNetworkService = NetworkSerivce(config: mostViewedConfig)
        self.mostViewedApiClient = MostViewedApiClient(networkService: mostViewedNetworkService)
    }
}
