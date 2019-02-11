//
//  APIClient.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    let baseURL = "http://api.nytimes.com/svc/mostpopular/"
    let apiVersion = "v2"
    let key = "YV5aKqdBRWAI2Dab3uHMKpNwHmvogGwz"
    let jsonDecoder = JSONDecoder()
    
    private func apiRequest (endpoint: String, completion: @escaping (_ result: RequestResult<Data>) -> Void ) {
        let url = baseURL + apiVersion + "/" + endpoint + "?api-key=" + key
        
        Alamofire.request(url).validate().responseJSON { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            guard let data = response.data else {
                completion(.failure(ServerError.invalidResponse))
                return
            }
            
            switch response.result {
            case .success:
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    internal func fetchJSONData<T: Codable>(endpoint: String, expectedType: T.Type, completion: @escaping (_ result: RequestResult<T>) -> Void) {
        apiRequest(endpoint: endpoint) { result in
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
}
