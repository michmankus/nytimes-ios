//
//  NetworkService.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    var config: ApiConfiguration { get }
    func apiRequest (endpoint: String, completion: @escaping (_ result: RequestResult<Data>) -> Void )
}

class NetworkSerivce: NetworkServiceProtocol {
    let config: ApiConfiguration
    
    func apiRequest (endpoint: String, completion: @escaping (_ result: RequestResult<Data>) -> Void ) {
        let url = config.baseURL + config.apiVersion + "/" + endpoint + "?api-key=" + config.key
        
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
    
    init(config: ApiConfiguration) {
        self.config = config
    }
}
