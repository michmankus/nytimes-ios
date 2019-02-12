//
//  APIClient.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation
import Alamofire

struct ApiConfiguration {
    let baseURL: String
    let apiVersion: String
    let key: String
}

class ApiClient {
    let networkService: NetworkServiceProtocol
    let jsonDecoder = JSONDecoder()
    
    internal func fetchJSONData<T: Codable>(endpoint: String, expectedType: T.Type, completion: @escaping (_ result: RequestResult<T>) -> Void) {
        networkService.apiRequest(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    init (networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
