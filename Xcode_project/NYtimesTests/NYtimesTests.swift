//
//  NYtimesTests.swift
//  NYtimesTests
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import XCTest
@testable import NYtimes

class NYtimesTests: XCTestCase {
    
    func testURLGenerating() {
        let config = ApiConfiguration(baseURL: "http://test.com/", apiVersion: "v1", key: "secretkey")
        let generatedURL = config.generateUrl(endpoint: "myendpoint/test/")
        let expectedURL = "http://test.com/v1/myendpoint/test/?api-key=secretkey"
        XCTAssertEqual(generatedURL, expectedURL)
    }
    
    func testCorrectNewsModels() {
        class MostViewedNetworkServiceMock: NetworkServiceProtocol {
            var config: ApiConfiguration {
                return ApiConfiguration(baseURL: "", apiVersion: "", key: "")
            }
            
            func apiRequest(endpoint: String, completion: @escaping (RequestResult<Data>) -> Void) {
                guard let mockData = """
                {
                    "status": "OK",
                    "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
                    "num_results": 1668,
                    "results": [
                        {
                            "url": "https://www.nytimes.com/2019/02/05/us/politics/fact-check-state-of-the-union.html",
                            "adx_keywords": "Trump, Donald J;State of the Union Message (US)",
                            "column": null,
                            "section": "U.S.",
                            "byline": "By THE NEW YORK TIMES",
                            "type": "Article",
                            "title": "State of the Union Fact Check: What Trump Got Right and Wrong",
                            "abstract": "President Trump appeared in front of a joint session of Congress for the annual address. Here is how his remarks stacked up against the facts.",
                            "published_date": "2019-02-05",
                            "source": "The New York Times",
                            "id": 100000006341465,
                            "asset_id": 100000006341465,
                            "views": 1,
                            "des_facet": [
                                "STATE OF THE UNION MESSAGE (US)"
                            ],
                            "org_facet": "",
                            "per_facet": [
                                "TRUMP, DONALD J"
                            ],
                            "geo_facet": "",
                            "media": [
                            ]
                        }
                   ]
                }
                """.data(using: .utf8) else { XCTFail("Incorrect product JSON"); return; }
                
                completion(.success(mockData))
            }
        }
        
        let callbackExpectation = expectation(description: "Network service has callback")
        
        let networkServiceMock = MostViewedNetworkServiceMock()
        let mostViewedApiClient = MostViewedApiClient(networkService: networkServiceMock)
        mostViewedApiClient.fetchMostViewed { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail()
            }
            callbackExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            if error != nil {
                XCTFail("waitForExpectationsWithTimeout")
            }
        }
    }
    
    func testIncorrectNewsModels() {
        class MostViewedNetworkServiceMock: NetworkServiceProtocol {
            var config: ApiConfiguration {
                return ApiConfiguration(baseURL: "", apiVersion: "", key: "")
            }
            
            func apiRequest(endpoint: String, completion: @escaping (RequestResult<Data>) -> Void) {
                guard let mockData = """
                {
                    "copyright": "Copyright (c) 2019 The New York Times Company.  All Rights Reserved.",
                    "num_results": 1668
                }
                """.data(using: .utf8) else { XCTFail("Incorrect product JSON"); return; }
                
                completion(.success(mockData))
            }
        }
        
        let callbackExpectation = expectation(description: "Network service has callback")
        
        let networkServiceMock = MostViewedNetworkServiceMock()
        let mostViewedApiClient = MostViewedApiClient(networkService: networkServiceMock)
        mostViewedApiClient.fetchMostViewed { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                break
            }
            callbackExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("waitForExpectationsWithTimeout")
            }
        }
    }

}
