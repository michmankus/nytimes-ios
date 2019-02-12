//
//  NYtimesUITests.swift
//  NYtimesUITests
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import XCTest

class NYtimesUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("--uitesting")
    }
    
    func testOpeningNews() {
        app.launch()
        
        XCTAssertTrue(app.otherElements["newsFeedView"].exists)
        
        let tableView = app.tables.matching(identifier: "newsFeedTableView")
        let cell = tableView.cells.element(matching: .cell, identifier: "newsCell").firstMatch
        cell.tap()
        
        let newsDetailView = app.otherElements["newsDetailView"]
        XCTAssert(newsDetailView.waitForExistence(timeout: 3))
        
        app.buttons["closeButton"].tap()

        let homeView = app.otherElements["newsFeedView"]
        XCTAssert(homeView.waitForExistence(timeout: 3))
    }

}
