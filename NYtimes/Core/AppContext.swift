//
//  AppContext.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

class AppContext {
    
    let apiClient: ApiClient
    
    init() {
        self.apiClient = ApiClient()
    }
}
