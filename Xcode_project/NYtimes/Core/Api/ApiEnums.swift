//
//  ApiEnums.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation

enum RequestResult<T> {
    case success(T)
    case failure(Error)
}

enum ServerError: Error {

    case invalidResponse
}
